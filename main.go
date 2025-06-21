package main

import (
	"movieFinder/app"
	"movieFinder/app/ctx/appCtx"
	"net/http"
	"os"
)

func main() {

	ac := appCtx.New()

	handler := app.Handler(&ac)

	addr := ":8080"

	ac.Logger.Info("Server live", "url", "http://localhost"+addr+"/")

	if err := http.ListenAndServe(addr, handler); err != nil {
		ac.Logger.Error("Failed to start server", "error", err)
		os.Exit(1)
	}
}
