package feedPage

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/ctx/reqCtx"
	"movieFinder/app/feed"
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

func respondPage(ac *appCtx.AppCtx) http.HandlerFunc {
	ac.Logger.Debug("initializing respondFeedPage handler")

	templPaths := []string{
		static.GetSiblingPath("feedPage.html"),
		document.TemplatePath,
		bottomButtons.TemplatePath,
	}
	templPaths = append(templPaths, feedSwiper.TemplatePaths...)
	ac.Logger.Debug("template paths", "paths", templPaths)

	templ := templateExt.Combine(templPaths)
	ac.Logger.Debug("combined templates")

	type Data struct {
		Document        document.Data
		Error           *string
		FeedSwiper      feedSwiper.FeedSwiper
		BottomButtons   bottomButtons.BottomButtons
		LoadNextURL     string
		SlideChangedURL string
	}

	baseData := Data{
		Error: nil,
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
	ac.Logger.Debug("initialized base data")

	queryPopularMedia, err := mediaDB.NewQueryPopularMedia(ac.DB)
	if err != nil {
		ac.Logger.Error("failed to create popular media query", "error", err)
		panic(err)
	}
	ac.Logger.Debug("created popular media query")

	return func(w http.ResponseWriter, r *http.Request) {
		ac.Logger.Debug("handling feed page request")
		rc := reqCtx.FromHttpRequest(ac, r)

		feedInst, err := feed.GetElseInsertBySessionID(ac.DB, rc.SessionID.String(), ac.Logger)
		if err != nil {
			ac.Logger.Error("failed to get/insert feed", "error", err, "sessionID", rc.SessionID.String())
		}
		ac.Logger.Debug("got feed instance", "feedID", feedInst.ID, "currentIndex", feedInst.CurrentFeedIndex)

		found, err := queryPopularMedia.Query(2, int(feedInst.CurrentFeedIndex))
		ac.Logger.Debug("queried popular media", "count", len(found), "startIndex", feedInst.CurrentFeedIndex)

		data := baseData

		if err != nil {
			ac.Logger.Error("failed to query popular media", "error", err)
			errStr := err.Error()
			data.Error = &errStr
			templateExt.Respond(templ, document.TemplateName, data, w)
			return
		}

		data.FeedSwiper.Slides = make([]feedSwiperSlides.FeedSwiperSlide, len(found))
		ac.Logger.Debug("allocated slides array", "length", len(found))

		for i, m := range found {
			slide := feedSwiperSlides.FromMedia(m, feedInst.CurrentFeedIndex+int64(i))
			data.FeedSwiper.Slides[i] = slide
		}
		ac.Logger.Debug("populated slides")

		templateExt.Respond(templ, document.TemplateName, data, w)
		ac.Logger.Debug("responded with template")
	}
}
