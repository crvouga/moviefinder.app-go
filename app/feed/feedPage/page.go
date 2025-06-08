package feedPage

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/routes"

	"movieFinder/lib/static"
	"net/http"
)

const routeLoadNext = "/load-next"
const routeSlideChanged = "/slide-changed"

func Router(mux *http.ServeMux, ac *appCtx.AppCtx) {
	mux.HandleFunc(routes.FeedPage, respondPage(ac))
	mux.HandleFunc(routeLoadNext, respondLoadNext(ac))
	mux.HandleFunc(routeSlideChanged, respondSlideChanged(ac))
}

var templatePath = static.GetSiblingPath("feedPage.html")

func Redirect(w http.ResponseWriter, r *http.Request) {
	http.Redirect(w, r, routes.FeedPage, http.StatusSeeOther)
}
