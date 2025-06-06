package feedPage

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/feed/feedPage/feedSwiper"
	"movieFinder/app/feed/feedPage/feedSwiperSlides"
	"movieFinder/app/media/mediaDB"
	"movieFinder/app/routes"
	"movieFinder/app/ui/appBottomButtons"
	"movieFinder/app/ui/bottomButtons"
	"movieFinder/app/ui/document"
	"movieFinder/app/ui/templateExt"
	"movieFinder/lib/static"
	"net/http"
)

func respondFeedPage(ac *appCtx.AppCtx) http.HandlerFunc {
	templPaths := []string{
		static.GetSiblingPath("feedPage.html"),
		document.TemplatePath,
		bottomButtons.TemplatePath,
	}
	templPaths = append(templPaths, feedSwiper.TemplatePaths...)
	templ := templateExt.Combine(templPaths)
	type Data struct {
		Document        document.Data
		FeedSwiper      feedSwiper.FeedSwiper
		BottomButtons   bottomButtons.BottomButtons
		LoadNextURL     string
		SlideChangedURL string
	}

	baseData := Data{
		Document: document.Data{
			Preload: []document.Preload{
				document.NewPreload(routes.UserAccountPage),
			},
		},
		FeedSwiper: feedSwiper.FeedSwiper{
			Slides: []feedSwiperSlides.FeedSwiperSlide{},
		},
		BottomButtons:   appBottomButtons.AppBottomButtons(appBottomButtons.FeedPage),
		LoadNextURL:     routeLoadNext,
		SlideChangedURL: routeSlideChanged,
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
		}
		templateExt.Respond(templ, document.TemplateName, data, w)
	}

}
