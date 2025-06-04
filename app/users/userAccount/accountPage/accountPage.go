package accountPage

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/home/homeRoutes"
	"movieFinder/app/ui/appBottomButtons"
	"movieFinder/app/ui/bottomButtons"
	"movieFinder/app/ui/page"
	"movieFinder/app/users/userAccount/userAccountRoutes"
	"movieFinder/lib/static"
	"net/http"
)

func Router(mux *http.ServeMux, ac *appCtx.AppCtx) {
	mux.HandleFunc(userAccountRoutes.UserAccountPage, Respond(ac))
}

func Respond(ac *appCtx.AppCtx) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {

		type Data struct {
			BottomButtons bottomButtons.BottomButtons
		}

		data := Data{
			BottomButtons: appBottomButtons.AppBottomButtons(appBottomButtons.AccountPage),
		}

		page.Respond(data, static.GetSiblingPath("accountPage.html"), bottomButtons.TemplatePath)(w, r)
	}
}

func Redirect(w http.ResponseWriter, r *http.Request) {
	http.Redirect(w, r, homeRoutes.HomePage, http.StatusSeeOther)
}
