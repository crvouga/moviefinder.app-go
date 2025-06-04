package home

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/home/homePage"

	"net/http"
)

func Router(mux *http.ServeMux, ac *appCtx.AppCtx) {
	homePage.Router(mux, ac)
}
