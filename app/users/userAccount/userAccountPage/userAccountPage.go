package userAccountPage

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/home/homeRoutes"
	icons "movieFinder/app/ui"
	"movieFinder/app/ui/appBottomButtons"
	"movieFinder/app/ui/bottomButtons"
	"movieFinder/app/ui/button"
	"movieFinder/app/ui/document"
	"movieFinder/app/ui/templateExt"
	"movieFinder/app/users/loginWithPhone/loginWithPhoneRoutes"
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
	templatePaths = append(templatePaths, button.TemplatePaths...)
	templ := templateExt.Combine(templatePaths)
	type Data struct {
		Document      document.Data
		BottomButtons bottomButtons.BottomButtons
		LoginCTA      loginCTA.Data
	}

	data := Data{
		Document: document.Data{
			Preload: []document.Preload{
				document.NewPreload(loginWithPhoneRoutes.SendCodePage),
				document.NewPreload(homeRoutes.HomePage),
			},
		},
		BottomButtons: appBottomButtons.AppBottomButtons(appBottomButtons.AccountPage),
		LoginCTA: loginCTA.Data{
			IconHTML: icons.DoorOpen(loginCTA.IconSize),
			LoginButton: button.Data{
				Text: "Login",
				Href: loginWithPhoneRoutes.SendCodePage,
			},
		},
	}
	return func(w http.ResponseWriter, r *http.Request) {
		templateExt.Respond(templ, document.TemplateName, data, w)
	}
}
