package main

import (
	"embed"
	"log"
	"movieFinder/app"
	"movieFinder/app/appDb"
	"movieFinder/lib/dbMigrations"
	"movieFinder/lib/tailwindcss"
	"net/http"

	_ "github.com/amacneil/dbmate/v2/pkg/driver/sqlite"
)

//go:embed db/migrations/*.sql
var MigrationsFs embed.FS

func main() {
	tailwindcss.Minify("./public/input.css", "./public/output.css")

	log.Println("Running migrations for", appDb.DbUrl)

	dbMigrations.Run(MigrationsFs, appDb.DbUrl)

	handler := app.Handler()

	addr := ":8080"

	log.Printf("Server live here http://localhost%s/ \n", addr)

	if err := http.ListenAndServe(addr, handler); err != nil {
		log.Fatal(err)
	}
}
