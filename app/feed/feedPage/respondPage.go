package feedPage

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/ctx/reqCtx"
	"movieFinder/app/feed/feedDB"
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

type Data struct {
	Document        document.Data
	Error           *string
	FeedSwiper      feedSwiper.FeedSwiper
	BottomButtons   bottomButtons.BottomButtons
	LoadNextURL     string
	SlideChangedURL string
}

func respondPage(ac *appCtx.AppCtx) http.HandlerFunc {
	templPaths := []string{
		static.GetSiblingPath("feedPage.html"),
		document.TemplatePath,
		bottomButtons.TemplatePath,
	}
	templPaths = append(templPaths, feedSwiper.TemplatePaths...)
	templ := templateExt.Combine(templPaths)

	queryPopularMedia, err := mediaDB.NewQueryPopularMedia(ac.DB)
	if err != nil {
		panic(err)
	}

	return func(w http.ResponseWriter, r *http.Request) {
		rc := reqCtx.FromHttpRequest(ac, r)

		feedRecord, err := feedDB.GetElseInsertBySessionID(ac.DB, rc.SessionID.String(), rc.Logger)

		if err != nil {
			rc.Logger.Error("failed to get/insert feed", "error", err)
		}

		found, err := queryPopularMedia.Query(FEED_SLIDE_BATCH_SIZE, int(feedRecord.CurrentFeedIndex))

		data := Data{
			Document: document.Data{
				Preload: []document.Preload{
					document.NewPreload(routes.USER_ACCOUNT),
				},
			},
			FeedSwiper: feedSwiper.FeedSwiper{
				Slides: []feedSwiperSlides.FeedSwiperSlide{},
			},
			BottomButtons:   appBottomButtons.AppBottomButtons(appBottomButtons.FeedPage),
			LoadNextURL:     ROUTE_LOAD_NEXT,
			SlideChangedURL: ROUTE_SLIDE_CHANGED,
		}

		if err != nil {
			errStr := err.Error()
			data.Error = &errStr
			templateExt.Respond(templ, document.TemplateName, data, w)
			return
		}

		data.FeedSwiper.Slides = make([]feedSwiperSlides.FeedSwiperSlide, len(found))
		for i, m := range found {
			data.FeedSwiper.Slides[i] = feedSwiperSlides.FromMedia(m, feedRecord.CurrentFeedIndex+int64(i), int64(i))
		}

		templateExt.Respond(templ, document.TemplateName, data, w)
	}
}
