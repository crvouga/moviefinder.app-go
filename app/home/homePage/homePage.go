package homePage

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/home/homePage/feedSwiper"
	"movieFinder/app/home/homePage/feedSwiperSlides"
	"movieFinder/app/home/homeRoutes"
	"movieFinder/app/ui/appBottomButtons"
	"movieFinder/app/ui/bottomButtons"
	"movieFinder/app/ui/document"
	"movieFinder/app/ui/templateExt"
	"movieFinder/lib/static"
	"net/http"
)

const LoadNext = "/load-next"

func Router(mux *http.ServeMux, ac *appCtx.AppCtx) {
	mux.HandleFunc(homeRoutes.HomePage, respondHomePage())
	mux.HandleFunc(LoadNext, respondLoadNext())
}

func respondLoadNext() http.HandlerFunc {
	templ := templateExt.Combine(
		feedSwiperSlides.TemplatePath,
	)
	return func(w http.ResponseWriter, r *http.Request) {
		type Data struct {
			FeedSwiper feedSwiper.FeedSwiper
		}

		data := Data{
			FeedSwiper: feedSwiper.FeedSwiper{
				Slides: []feedSwiperSlides.FeedSwiperSlide{
					{ImageSrc: "https://picsum.photos/200/300", URL: "https://picsum.photos/200/300"},
				},
			},
		}

		templateExt.Respond(templ, feedSwiperSlides.TemplateName, data, w)

	}
}

func respondHomePage() http.HandlerFunc {
	templ := templateExt.Combine(
		static.GetSiblingPath("homePage.html"),
		document.TemplatePath,
		bottomButtons.TemplatePath,
		feedSwiper.TemplatePath,
		feedSwiperSlides.TemplatePath,
	)
	return func(w http.ResponseWriter, r *http.Request) {

		type Data struct {
			FeedSwiper    feedSwiper.FeedSwiper
			BottomButtons bottomButtons.BottomButtons
			LoadNextURL   string
		}

		data := Data{
			FeedSwiper: feedSwiper.FeedSwiper{
				Slides: []feedSwiperSlides.FeedSwiperSlide{
					{ImageSrc: "https://picsum.photos/200/300", URL: "https://picsum.photos/200/300"},
				},
			},
			BottomButtons: appBottomButtons.AppBottomButtons(appBottomButtons.HomePage),
			LoadNextURL:   LoadNext,
		}

		templateExt.Respond(templ, document.TemplateName, data, w)

	}

}

var templatePath = static.GetSiblingPath("homePage.html")

func Redirect(w http.ResponseWriter, r *http.Request) {
	http.Redirect(w, r, homeRoutes.HomePage, http.StatusSeeOther)
}
