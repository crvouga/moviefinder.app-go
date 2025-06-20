package feedPage

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/routes"

	"movieFinder/lib/static"
	"net/http"
)

const (
	ROUTE_LOAD_NEXT       = "/load-next"
	ROUTE_SLIDE_CHANGED   = "/slide-changed"
	FEED_SLIDE_BATCH_SIZE = 5
)

func Router(mux *http.ServeMux, ac *appCtx.AppCtx) {
	mux.HandleFunc(routes.FEED_PAGE, respondPage(ac))
	mux.HandleFunc(ROUTE_LOAD_NEXT, respondLoadNext(ac))
	mux.HandleFunc(ROUTE_SLIDE_CHANGED, respondSlideChanged(ac))
}

var templatePath = static.GetSiblingPath("feedPage.html")

func Redirect(w http.ResponseWriter, r *http.Request) {
	http.Redirect(w, r, routes.FEED_PAGE, http.StatusSeeOther)
}
