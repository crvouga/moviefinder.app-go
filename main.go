package main

import (
	"embed"
	"movieFinder/app"
	"movieFinder/app/ctx/appCtx"
	"net/http"
	"os"

	_ "embed"
)

//go:embed db/migrations
var migrations embed.FS

func main() {
	ac := appCtx.New()

	err := ac.Postgres.MigrateUp(migrations)

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
