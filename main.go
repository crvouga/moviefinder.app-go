package main

import (
	"embed"
	"log"
	"movieFinder/app"
	appDb "movieFinder/app/db"
	"movieFinder/lib/dbMigrations"
	"movieFinder/lib/tailwindcss"
	"net/http"

	_ "github.com/amacneil/dbmate/v2/pkg/driver/sqlite"
)

//go:embed db/migrations/*.sql
var migrationsFs embed.FS

func main() {
	tailwindcss.Minify("./public/input.css", "./public/output.css")

	dbUrl := "sqlite:" + appDb.DB_PATH

	log.Println("Running migrations for", dbUrl)

	dbMigrations.Run(migrationsFs, dbUrl)

	handler := app.Handler()

	addr := ":8080"

	log.Printf("Server live here http://localhost%s/ \n", addr)

	if err := http.ListenAndServe(addr, handler); err != nil {
		log.Fatal(err)
	}
}
