package homePage

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/home/homePage/feedSwiper"
	"movieFinder/app/home/homePage/feedSwiperSlides"
	"movieFinder/app/home/homeRoutes"
	"movieFinder/app/media/mediaDB"
	"movieFinder/app/ui/appBottomButtons"
	"movieFinder/app/ui/bottomButtons"
	"movieFinder/app/ui/document"
	"movieFinder/app/ui/templateExt"
	"movieFinder/app/users/userAccount/userAccountRoutes"
	"movieFinder/lib/static"
	"net/http"
)

const LoadNext = "/load-next"

func Router(mux *http.ServeMux, ac *appCtx.AppCtx) {
	mux.HandleFunc(homeRoutes.HomePage, respondHomePage(ac))
	mux.HandleFunc(LoadNext, respondLoadNext(ac))
}

func respondLoadNext(ac *appCtx.AppCtx) http.HandlerFunc {
	templ := templateExt.Combine([]string{
		feedSwiperSlides.TemplatePath,
	})
	type Data struct {
		FeedSwiper feedSwiper.FeedSwiper
	}

	baseData := Data{
		FeedSwiper: feedSwiper.FeedSwiper{
			Slides: []feedSwiperSlides.FeedSwiperSlide{},
		},
	}

	queryPopularMedia, err := mediaDB.NewQueryPopularMedia(ac.DB)

	if err != nil {
		panic(err)
	}

	return func(w http.ResponseWriter, r *http.Request) {
		media, err := queryPopularMedia.Query(10, 0)
		if err != nil {
			panic(err)
		}
		data := baseData
		data.FeedSwiper.Slides = make([]feedSwiperSlides.FeedSwiperSlide, len(media))
		for i, m := range media {
			data.FeedSwiper.Slides[i] = feedSwiperSlides.FromMedia(m)
		}
		templateExt.Respond(templ, feedSwiperSlides.TemplateName, data, w)
	}
}

func respondHomePage(ac *appCtx.AppCtx) http.HandlerFunc {
	templPaths := []string{
		static.GetSiblingPath("homePage.html"),
		document.TemplatePath,
		bottomButtons.TemplatePath,
	}
	templPaths = append(templPaths, feedSwiper.TemplatePaths...)
	templ := templateExt.Combine(templPaths)
	type Data struct {
		Document      document.Data
		FeedSwiper    feedSwiper.FeedSwiper
		BottomButtons bottomButtons.BottomButtons
		LoadNextURL   string
	}

	baseData := Data{
		Document: document.Data{
			Preload: []document.Preload{
				document.NewPreload(userAccountRoutes.UserAccountPage),
			},
		},
		FeedSwiper: feedSwiper.FeedSwiper{
			Slides: []feedSwiperSlides.FeedSwiperSlide{},
		},
		BottomButtons: appBottomButtons.AppBottomButtons(appBottomButtons.HomePage),
		LoadNextURL:   LoadNext,
	}

	queryPopularMedia, err := mediaDB.NewQueryPopularMedia(ac.DB)

	if err != nil {
		panic(err)
	}

	return func(w http.ResponseWriter, r *http.Request) {
		found, err := queryPopularMedia.Query(3, 0)
		if err != nil {
			panic(err)
		}
		data := baseData
		data.FeedSwiper.Slides = make([]feedSwiperSlides.FeedSwiperSlide, len(found))
		for i, m := range found {
			slide := feedSwiperSlides.FromMedia(m)
			data.FeedSwiper.Slides[i] = slide
			// data.Document.Preload = append(data.Document.Preload, document.NewPreload(slide.URL))
			// data.Document.Preload = append(data.Document.Preload, document.NewPreload(m.BackdropURL))
		}
		templateExt.Respond(templ, document.TemplateName, data, w)
	}

}

var templatePath = static.GetSiblingPath("homePage.html")

func Redirect(w http.ResponseWriter, r *http.Request) {
	http.Redirect(w, r, homeRoutes.HomePage, http.StatusSeeOther)
}
