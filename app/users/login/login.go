package login

import (
	"net/http"

	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/users/login/sendLink"
	"movieFinder/app/users/login/useLink"
)

func Router(mux *http.ServeMux, ac *appCtx.AppCtx) {
	useLink.Router(mux, ac)
}

func RouterLoggedOut(mux *http.ServeMux, ac *appCtx.AppCtx) {
	sendLink.Router(mux, ac)
	useLink.Router(mux, ac)
}
