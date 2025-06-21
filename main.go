package main

import (
	"movieFinder/app"
	"movieFinder/app/ctx/appCtx"
	"movieFinder/db"
	"net/http"
	"os"

	_ "embed"
)

func main() {
	ac := appCtx.New()

	err := ac.Postgres.MigrateUp(db.MigrationsFs, db.MigrationsDir)

	if err != nil {
		ac.Logger.Error("Failed to migrate up", "error", err)
		os.Exit(1)
	}

	handler := app.Handler(&ac)

	addr := ":8080"

	ac.Logger.Info("Server live", "url", "http://localhost"+addr+"/")

	if err := http.ListenAndServe(addr, handler); err != nil {
		ac.Logger.Error("Failed to start server", "error", err)
		os.Exit(1)
	}
}
