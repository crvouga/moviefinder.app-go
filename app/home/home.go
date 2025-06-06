package home

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/home/feedPage"

	"net/http"
)

func Router(mux *http.ServeMux, ac *appCtx.AppCtx) {
	feedPage.Router(mux, ac)
}
