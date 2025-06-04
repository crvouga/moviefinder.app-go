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

const LoadNext = "/loadNext"

func Router(mux *http.ServeMux, ac *appCtx.AppCtx) {
	mux.HandleFunc(homeRoutes.HomePage, func(w http.ResponseWriter, r *http.Request) {
		_q := `SELECT media_id, title, poster_urls, popularity FROM media ORDER BY popularity DESC LIMIT 10`

		println(_q)

		type Data struct {
			FeedSwiper    feedSwiper.FeedSwiper
			BottomButtons bottomButtons.BottomButtons
			LoadNextURL   string
		}

		data := Data{
			FeedSwiper: feedSwiper.FeedSwiper{
				Slides: []feedSwiper.FeedSwiperSlide{
					{ImageSrc: "https://picsum.photos/200/300", URL: "https://picsum.photos/200/300"},
					{ImageSrc: "https://picsum.photos/200/300", URL: "https://picsum.photos/200/300"},
					{ImageSrc: "https://picsum.photos/200/300", URL: "https://picsum.photos/200/300"},
					{ImageSrc: "https://picsum.photos/200/300", URL: "https://picsum.photos/200/300"},
				},
			},
			BottomButtons: appBottomButtons.AppBottomButtons(appBottomButtons.HomePage),
			LoadNextURL:   LoadNext,
		}

		page.Respond(data, templatePath, bottomButtons.TemplatePath, feedSwiper.TemplatePath, feedSwiper.TemplatePathSwiperSlides)(w, r)
	})

	mux.HandleFunc(LoadNext, func(w http.ResponseWriter, r *http.Request) {
		_q := `SELECT media_id, title, poster_urls, popularity FROM media ORDER BY popularity DESC LIMIT 10`

		println(_q)

		type Data struct {
			FeedSwiper feedSwiper.FeedSwiper
		}

		data := Data{
			FeedSwiper: feedSwiper.FeedSwiper{
				Slides: []feedSwiper.FeedSwiperSlide{
					{ImageSrc: "https://picsum.photos/200/300", URL: "https://picsum.photos/200/300"},
					{ImageSrc: "https://picsum.photos/200/300", URL: "https://picsum.photos/200/300"},
					{ImageSrc: "https://picsum.photos/200/300", URL: "https://picsum.photos/200/300"},
					{ImageSrc: "https://picsum.photos/200/300", URL: "https://picsum.photos/200/300"},
				},
			},
		}

		page.Respond(data, feedSwiper.TemplatePathSwiperSlides)(w, r)
	})
}

var templatePath = static.GetSiblingPath("homePage.html")

func Redirect(w http.ResponseWriter, r *http.Request) {
	http.Redirect(w, r, homeRoutes.HomePage, http.StatusSeeOther)
}
