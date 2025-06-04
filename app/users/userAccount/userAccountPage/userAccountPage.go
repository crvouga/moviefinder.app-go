package userAccountPage

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/ui/appBottomButtons"
	"movieFinder/app/ui/bottomButtons"
	"movieFinder/app/ui/button"
	"movieFinder/app/ui/document"
	"movieFinder/app/ui/templateExt"
	"movieFinder/app/users/userAccount/userAccountPage/loginCTA"
	"movieFinder/app/users/userAccount/userAccountRoutes"
	"movieFinder/lib/static"
	"net/http"
)

func Router(mux *http.ServeMux, ac *appCtx.AppCtx) {
	mux.HandleFunc(userAccountRoutes.UserAccountPage, Respond(ac))
}

func Respond(ac *appCtx.AppCtx) http.HandlerFunc {
	templatePaths := []string{
		static.GetSiblingPath("userAccountPage.html"),
		document.TemplatePath,
		bottomButtons.TemplatePath,
	}
	templatePaths = append(templatePaths, loginCTA.TemplatePaths...)
	templ := templateExt.Combine(templatePaths)
	return func(w http.ResponseWriter, r *http.Request) {

		type Data struct {
			BottomButtons bottomButtons.BottomButtons
			LoginCTA      loginCTA.Data
		}

		data := Data{
			BottomButtons: appBottomButtons.AppBottomButtons(appBottomButtons.AccountPage),
			LoginCTA: loginCTA.Data{
				LoginButton: button.Data{
					Text: "Login",
				},
			},
		}

		templateExt.Respond(templ, document.TemplateName, data, w)
	}
}
