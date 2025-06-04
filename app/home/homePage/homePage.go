package homePage

import (
	"movieFinder/app/apiDocs/apiDocsRoutes"
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/home/homeRoutes"
	"movieFinder/app/projects/projectRoutes"
	"movieFinder/app/ui/mainMenu"
	"movieFinder/app/ui/page"
	"movieFinder/app/ui/pageHeader"
	"movieFinder/app/users/userAccount/userAccountRoutes"
	"movieFinder/lib/static"
	"net/http"
)

func Router(mux *http.ServeMux, ac *appCtx.AppCtx) {
	mux.HandleFunc(homeRoutes.HomePage, Respond(ac))
}

const (
	PageTitle = "Home"
)

type Data struct {
	PageHeader pageHeader.PageHeader
	MainMenu   mainMenu.MainMenu
}

func Respond(ac *appCtx.AppCtx) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		// _rc := reqCtx.FromHttpRequest(ac, r)

		mainMenuData := mainMenu.MainMenu{
			Items: []mainMenu.MainMenuItem{
				{
					Label:       "Projects",
					Description: "Manage your projects",
					URL:         projectRoutes.ToListProjects(),
				},
				{
					Label:       "Account",
					Description: "Manage your account",
					URL:         userAccountRoutes.UserAccountPage,
				},
				{
					Label:       "HTTP API Docs",
					Description: "View the documentation for the HTTP API",
					URL:         apiDocsRoutes.ApiDocsPage,
				},
			},
		}

		data := Data{
			PageHeader: pageHeader.PageHeader{
				Title: PageTitle,
			},
			MainMenu: mainMenuData,
		}

		page.Respond(data, static.GetSiblingPath("homePage.html"))(w, r)
	}
}

func Redirect(w http.ResponseWriter, r *http.Request) {
	http.Redirect(w, r, homeRoutes.HomePage, http.StatusSeeOther)
}
