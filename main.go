package main

import (
	"bytes"
	"fmt"
	"html/template"
	"net/http"
	"time"

	"moviefinder.app/feed"
	"moviefinder.app/ui"
)

func main() {
	http.HandleFunc("/", handler)

	fmt.Println("Starting server on :8080...")
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		fmt.Println("Error starting server:", err)
	}
}

func handler(w http.ResponseWriter, r *http.Request) {
	if isHxRequest(r) {
		routeHx(w, r)
		return
	}

	route(w, r)
}

func routeHx(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Handling htmx request...", r.URL.Path)
	switch r.URL.Path {
	case "/feed":
		feed.RouteHx(w, r)
		return

	default:
		time.Sleep(1 * time.Second)
		path := r.URL.Path
		fmt.Println("Handling htmx request...", path)
		w.Header().Set("Content-Type", "text/html")
		fmt.Fprintln(w, "<h1>Loaded via htmx!</h1>")
		return
	}
}

func route(w http.ResponseWriter, r *http.Request) {
	html := document(r.URL.Path)
	w.Header().Set("Content-Type", "text/html")
	fmt.Fprintln(w, html)
}

func isHxRequest(r *http.Request) bool {
	return r.Header.Get("HX-Request") == "true"
}

const documentTemplate = `
<!doctype html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://unpkg.com/htmx.org@2.0.1"></script>
    </head>
    <body class="bg-black text-white flex flex-col items-center justify-center w-full h-[100dvh] max-h-[100dvh]">
        <div 
            id="app"
            class="w-full max-w-[500px] h-full max-h-[800px] border rounded overflow-hidden"
        >
            <div
                class="w-full h-full flex items-center justify-center"
                hx-get="{{.Route}}"
                hx-trigger="load"
                hx-target="#app"
                hx-swap="innerHTML"
            >
                {{.Spinner}}
            </div>
        </div>
    </body>
</html>`

type DocumentData struct {
	Spinner template.HTML
	Route   string
}

func document(route string) string {
	tmpl, err := template.New("document").Parse(documentTemplate)
	if err != nil {
		panic(err)
	}

	data := DocumentData{
		Spinner: template.HTML(ui.Spinner()),
		Route:   route,
	}

	var result bytes.Buffer
	err = tmpl.Execute(&result, data)
	if err != nil {
		panic(err)
	}

	return result.String()
}
