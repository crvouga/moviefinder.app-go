package admin

import (
	"movieFinder/app/admin/adminPage"
	"movieFinder/app/admin/claimAdmin"
	"movieFinder/app/ctx/appCtx"
	"net/http"
)

func Router(mux *http.ServeMux, ac *appCtx.AppCtx) {
	claimAdmin.Router(mux, ac)
	adminPage.Router(mux, ac)
}
