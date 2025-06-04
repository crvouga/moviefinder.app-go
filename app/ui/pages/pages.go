package pages

import (
	"movieFinder/app/ui/confirmationPage"
	"movieFinder/app/ui/errorPage"
	"movieFinder/app/ui/notFoundPage"
	"movieFinder/app/ui/successPage"
	"net/http"
)

func Router(mux *http.ServeMux) {
	confirmationPage.Router(mux)
	errorPage.Router(mux)
	successPage.Router(mux)
	notFoundPage.Router(mux)
}
