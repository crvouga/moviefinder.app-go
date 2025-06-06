package main

import (
	"log"
	"movieFinder/app"
	"movieFinder/lib/tailwindcss"
	"net/http"
)

func main() {
	tailwindcss.Minify("./public/input.css", "./public/output.css")

	handler := app.Handler()

	addr := ":8080"

	log.Printf("Server live here http://localhost%s/ \n", addr)

	if err := http.ListenAndServe(addr, handler); err != nil {
		log.Fatal(err)
	}
}
