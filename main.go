package main

import (
	"context"
	"errors"
	"movieFinder/app"
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/media/workerMediaDB"
	"movieFinder/db"
	"movieFinder/lib/dotEnv"
	"net/http"
	"os"
	"os/signal"
	"sync/atomic"
	"syscall"
	"time"

	_ "embed"
)

// readinessGate exposes /health for Fly probes and serves 200 on other paths
// while migrations run. After ready, traffic is routed to the app handler.
type readinessGate struct {
	ready atomic.Bool
	app   http.Handler
}

func (g *readinessGate) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	if r.URL.Path == "/health" {
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		_, _ = w.Write([]byte(`{"status":"ok"}`))
		return
	}

	if !g.ready.Load() {
		w.WriteHeader(http.StatusOK)
		return
	}

	g.app.ServeHTTP(w, r)
}

func main() {
	// Load environment variables from .env file
	if err := dotEnv.Load(); err != nil {
		// Log error but don't fail - .env file is optional
		// Environment variables can also be set via system/env
	}

	ac := appCtx.New()

	ctx, stop := signal.NotifyContext(context.Background(), os.Interrupt, syscall.SIGTERM)
	defer stop()

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	addr := ":" + port

	gate := &readinessGate{}
	server := &http.Server{
		Addr:    addr,
		Handler: gate,
	}

	go func() {
		ac.Logger.Info("Server listening", "addr", addr)
		if err := server.ListenAndServe(); err != nil && !errors.Is(err, http.ErrServerClosed) {
			ac.Logger.Error("Failed to start server", "error", err)
			os.Exit(1)
		}
	}()

	err := ac.Postgres.MigrateUp(db.MigrationsFs, db.MigrationsDir)

	if err != nil {
		ac.Logger.Error("Failed to migrate up", "error", err)
		os.Exit(1)
	}

	// Initialize materialized views before starting the server
	ac.Logger.Info("Initializing materialized views...")
	matViews := workerMediaDB.NewMatViews(ac.DB, ac.Logger)
	if err := matViews.Init(); err != nil {
		ac.Logger.Error("Failed to initialize materialized views", "error", err)
		os.Exit(1)
	}
	ac.Logger.Info("Materialized views initialized successfully")

	handler, stopWorkers := app.Handler(&ac, ctx)
	defer stopWorkers()

	gate.app = handler
	gate.ready.Store(true)

	<-ctx.Done()

	ac.Logger.Info("Shutting down server...")

	shutdownCtx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	if err := server.Shutdown(shutdownCtx); err != nil {
		ac.Logger.Error("Server shutdown failed", "error", err)
	}

	ac.Logger.Info("Server gracefully stopped")
}
