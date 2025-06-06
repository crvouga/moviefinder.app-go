package users

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/users/loginWithPhone/sendCodePage"
	"movieFinder/app/users/loginWithPhone/verifyCodePage"
	"movieFinder/app/users/userAccount/userAccountPage"
	"net/http"
)

func Router(mux *http.ServeMux, ac *appCtx.AppCtx) {
	userAccountPage.Router(mux, ac)

}

func RouterLoggedOut(mux *http.ServeMux, ac *appCtx.AppCtx) {
	userAccountPage.Router(mux, ac)
	sendCodePage.Router(mux)
	verifyCodePage.Router(mux)
}
