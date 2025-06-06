package main

import (
	"log"
	"movieFinder/app"
	"movieFinder/app/appDb"
	"movieFinder/lib/tailwindcss"
	"net/http"

	_ "github.com/amacneil/dbmate/v2/pkg/driver/sqlite"
)

func main() {
	tailwindcss.Minify("./public/input.css", "./public/output.css")

	appDb.RunMigrations()

	handler := app.Handler()

	addr := ":8080"

	log.Printf("Server live here http://localhost%s/ \n", addr)

	if err := http.ListenAndServe(addr, handler); err != nil {
		log.Fatal(err)
	}
}
