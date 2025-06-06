package feed

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/feed/feedPage"

	"net/http"
)

func Router(mux *http.ServeMux, ac *appCtx.AppCtx) {
	feedPage.Router(mux, ac)
}
