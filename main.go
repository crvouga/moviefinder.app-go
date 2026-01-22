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
	"syscall"
	"time"

	_ "embed"
)

func main() {
	// Load environment variables from .env file
	if err := dotEnv.Load(); err != nil {
		// Log error but don't fail - .env file is optional
		// Environment variables can also be set via system/env
	}

	ac := appCtx.New()

	ctx, stop := signal.NotifyContext(context.Background(), os.Interrupt, syscall.SIGTERM)
	defer stop()

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

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	addr := ":" + port

	server := &http.Server{
		Addr:    addr,
		Handler: handler,
	}

	go func() {
		ac.Logger.Info("Server live", "url", "http://localhost"+addr+"/")
		if err := server.ListenAndServe(); err != nil && !errors.Is(err, http.ErrServerClosed) {
			ac.Logger.Error("Failed to start server", "error", err)
			os.Exit(1)
		}
	}()

	<-ctx.Done()

	ac.Logger.Info("Shutting down server...")

	shutdownCtx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	if err := server.Shutdown(shutdownCtx); err != nil {
		ac.Logger.Error("Server shutdown failed", "error", err)
	}

	ac.Logger.Info("Server gracefully stopped")
}
