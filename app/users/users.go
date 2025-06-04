package users

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/users/login"
	"movieFinder/app/users/logout"
	"movieFinder/app/users/userAccount/accountPage"
	"net/http"
)

func Router(mux *http.ServeMux, ac *appCtx.AppCtx) {
	logout.Router(mux, ac)
	login.Router(mux, ac)
	accountPage.Router(mux, ac)
}

func RouterLoggedOut(mux *http.ServeMux, ac *appCtx.AppCtx) {
	login.RouterLoggedOut(mux, ac)
}
