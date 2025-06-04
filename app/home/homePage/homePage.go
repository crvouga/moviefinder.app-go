package homePage

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/home/homePage/feedSwiper"
	"movieFinder/app/home/homeRoutes"
	"movieFinder/app/ui/appBottomButtons"
	"movieFinder/app/ui/bottomButtons"
	"movieFinder/app/ui/page"
	"movieFinder/lib/static"
	"net/http"
)

func Router(mux *http.ServeMux, ac *appCtx.AppCtx) {
	mux.HandleFunc(homeRoutes.HomePage, Respond(ac))
}

var templatePath = static.GetSiblingPath("homePage.html")

func Respond(ac *appCtx.AppCtx) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {

		type Data struct {
			FeedSwiper    feedSwiper.FeedSwiper
			BottomButtons bottomButtons.BottomButtons
		}

		data := Data{
			FeedSwiper: feedSwiper.FeedSwiper{
				Items: []feedSwiper.FeedSwiperItem{
					{ImageSrc: "https://picsum.photos/200/300", URL: "https://picsum.photos/200/300"},
					{ImageSrc: "https://picsum.photos/200/300", URL: "https://picsum.photos/200/300"},
					{ImageSrc: "https://picsum.photos/200/300", URL: "https://picsum.photos/200/300"},
					{ImageSrc: "https://picsum.photos/200/300", URL: "https://picsum.photos/200/300"},
				},
			},
			BottomButtons: appBottomButtons.AppBottomButtons(appBottomButtons.HomePage),
		}

		page.Respond(data, templatePath, bottomButtons.TemplatePath, feedSwiper.TemplatePath)(w, r)
	}
}

func Redirect(w http.ResponseWriter, r *http.Request) {
	http.Redirect(w, r, homeRoutes.HomePage, http.StatusSeeOther)
}
