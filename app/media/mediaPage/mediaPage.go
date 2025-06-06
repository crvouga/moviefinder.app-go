package mediaPage

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/home/homeRoutes"
	"movieFinder/app/media"
	"movieFinder/app/media/mediaDB"
	"movieFinder/app/routes"
	"movieFinder/app/ui/document"
	"movieFinder/app/ui/templateExt"
	"movieFinder/app/ui/topBar"
	"movieFinder/app/users/userAccount/userAccountRoutes"
	"movieFinder/lib/static"
	"net/http"
)

func Router(mux *http.ServeMux, ac *appCtx.AppCtx) {
	mux.HandleFunc(routes.MediaPagePath, respondMediaPage(ac))
}

func respondMediaPage(ac *appCtx.AppCtx) http.HandlerFunc {
	templPaths := []string{
		static.GetSiblingPath("mediaPage.html"),
		document.TemplatePath,
		topBar.TemplatePath,
	}

	templ := templateExt.Combine(templPaths)

	type Data struct {
		Document document.Data
		TopBar   topBar.Data
		Media    media.Media
	}

	baseData := Data{
		Document: document.Data{
			Preload: []document.Preload{
				document.NewPreload(userAccountRoutes.UserAccountPage),
			},
		},
		TopBar: topBar.Data{
			Title:    "",
			BackHref: homeRoutes.FeedPage,
		},
		Media: media.Media{},
	}

	queryMediaByID, err := mediaDB.NewQueryMediaByID(ac.DB)

	if err != nil {
		panic(err)
	}

	return func(w http.ResponseWriter, r *http.Request) {
		mediaID := r.URL.Query().Get("mediaID")
		found, err := queryMediaByID.Query(mediaID)
		if err != nil {
			panic(err)
		}
		data := baseData
		if found != nil {
			data.TopBar.Title = found.Title
			data.Media = *found
		}
		templateExt.Respond(templ, document.TemplateName, data, w)
	}

}

var templatePath = static.GetSiblingPath("feedPage.html")

func Redirect(w http.ResponseWriter, r *http.Request) {
	http.Redirect(w, r, homeRoutes.FeedPage, http.StatusSeeOther)
}
