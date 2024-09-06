package main

import (
	"fmt"
	"net/http"
	"time"

	"moviefinder.app/feed"
	h "moviefinder.app/html"
	a "moviefinder.app/html/attr"
)

func main() {
	http.HandleFunc("/", handler)
	fmt.Println("Starting server on http://localhost:8080...")
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		fmt.Println("Error starting server:", err)
	}
}

func handler(w http.ResponseWriter, r *http.Request) {
	if r.Header.Get("HX-Request") == "true" {
		routeHx(w, r)
		return
	}

	route(w, r)
}

func routeHx(w http.ResponseWriter, r *http.Request) {

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

func route(w http.ResponseWriter, _ *http.Request) {
	h.WriteTo(w, viewDocument())
}

func viewDocument() h.HTML {
	return h.Html5_(
		h.Head_(
			h.Meta(h.Attr(a.Charset_("UTF-8"))),
			h.Meta(
				h.Attr(a.Name_("viewport"), a.Content_("width=device-width"), a.InitialScale_("1")),
			),

			h.Link(
				h.Attr(
					a.Rel_("stylesheet"),
					a.Href_("data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 36 36'><text y='32' font-size='32'>🍿</text></svg>"),
				),
			),
			h.Script(h.Attr(a.Src_("https://cdn.tailwindcss.com")), h.JavaScript("")),
			h.Script(h.Attr(a.Src_("https://unpkg.com/htmx.org@2.0.1")), h.JavaScript("")),
		),
		h.Body(
			h.Attr(
				a.Class_("bg-black text-white flex flex-col items-center justify-center w-full h-[100dvh] max-h-[100dvh]"),
			),
			h.Div(
				h.Attr(
					a.Id_("app"),
					a.Class_("w-full max-w-[500px] h-full max-h-[800px] border rounded overflow-hidden"),
				),
				h.Div(
					h.Attr(
						a.Class_("w-full h-full flex items-center justify-center"),
						// a.HxGet_("{{.Route}}"),
						// a.HxTrigger_("load"),
						// a.HxTarget_("#app"),
						// a.HxSwap_("innerHTML"),
					),
					// Spinner(),
				),
			),
		),
	)
}
