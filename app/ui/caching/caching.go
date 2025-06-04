package caching

import (
	"net/http"
	"time"
)

func Yes(w http.ResponseWriter) {
	w.Header().Set("Cache-Control", "public, max-age=31536000")
	w.Header().Set("Expires", time.Now().AddDate(1, 0, 0).Format(time.RFC1123))
	w.Header().Set("Vary", "Accept-Encoding")
}

func No(w http.ResponseWriter) {
	w.Header().Set("Cache-Control", "no-cache, no-store, must-revalidate")
	w.Header().Set("Pragma", "no-cache")
	w.Header().Set("Expires", "0")
}
