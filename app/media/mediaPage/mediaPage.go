package mediaPage

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/media"
	"movieFinder/app/media/mediaDB"
	"movieFinder/app/routes"
	"movieFinder/app/ui/document"
	"movieFinder/app/ui/templateExt"
	"movieFinder/app/ui/topBar"
	"movieFinder/lib/static"
	"net/http"
)

func Router(mux *http.ServeMux, ac *appCtx.AppCtx) {
	mux.HandleFunc(routes.MEDIA_PAGE, respondMediaPage(ac))
}

type Data struct {
	Document document.Data
	TopBar   topBar.Data
	Media    media.Media
}

func respondMediaPage(ac *appCtx.AppCtx) http.HandlerFunc {
	templ := templateExt.Combine([]string{
		static.GetSiblingPath("mediaPage.html"),
		document.TemplatePath,
		topBar.TemplatePath,
	})

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

		data := Data{
			Document: document.Data{
				Preload: []document.Preload{
					document.NewPreload(routes.USER_ACCOUNT),
				},
			},
			TopBar: topBar.Data{
				Title:    "",
				BackHref: routes.FEED_PAGE,
			},
			Media: media.Media{},
		}

		if found != nil {
			data.TopBar.Title = found.Title
			data.Media = *found
		}

		templateExt.Respond(templ, document.TemplateName, data, w)
	}

}
