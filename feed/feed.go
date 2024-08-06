package feed

import (
	"fmt"
	"net/http"
)

func RouteHx(w http.ResponseWriter, r *http.Request) {

	switch r.URL.Path {
	case "/feed":
		w.Header().Set("Content-Type", "text/html")
		fmt.Fprintln(w, "<h1>Feed!</h1>")
		return
	case "/feed/load":
		w.Header().Set("Content-Type", "text/html")
		fmt.Fprintln(w, "<h1>Feed!</h1>")
		return
	default:
		w.Header().Set("Content-Type", "text/html")
		fmt.Fprintln(w, "<h1>Feed!</h1>")
		return
	}
}
