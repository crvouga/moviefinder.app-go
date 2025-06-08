package feedPage

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/ctx/reqCtx"
	"movieFinder/app/feed"
	"movieFinder/app/feed/feedPage/feedSwiper"
	"movieFinder/app/feed/feedPage/feedSwiperSlides"
	"movieFinder/app/media/mediaDB"
	"movieFinder/app/ui/templateExt"
	"net/http"
)

func respondLoadNext(ac *appCtx.AppCtx) http.HandlerFunc {
	ac.Logger.Debug("initializing respondLoadNext handler")

	templ := templateExt.Combine([]string{
		feedSwiperSlides.TemplatePath,
	})
	ac.Logger.Debug("combined templates", "templatePath", feedSwiperSlides.TemplatePath)

	type Data struct {
		Error      *string
		FeedSwiper feedSwiper.FeedSwiper
	}

	baseData := Data{
		Error: nil,
		FeedSwiper: feedSwiper.FeedSwiper{
			Slides: []feedSwiperSlides.FeedSwiperSlide{},
		},
	}

	queryPopularMedia, err := mediaDB.NewQueryPopularMedia(ac.DB)
	if err != nil {
		ac.Logger.Error("failed to create popular media query", "error", err)
		panic(err)
	}
	ac.Logger.Debug("created popular media query")

	return func(w http.ResponseWriter, r *http.Request) {
		ac.Logger.Debug("handling load next request")
		rc := reqCtx.FromHttpRequest(ac, r)

		feedInst, err := feed.GetElseInsertBySessionID(ac.DB, rc.SessionID.String(), ac.Logger)
		if err != nil {
			ac.Logger.Error("failed to get/insert feed", "error", err, "sessionID", rc.SessionID.String())
		}
		ac.Logger.Debug("got feed instance", "feedID", feedInst.ID, "currentIndex", feedInst.CurrentFeedIndex)

		media, err := queryPopularMedia.Query(10, int(feedInst.CurrentFeedIndex))
		ac.Logger.Debug("queried popular media", "count", len(media), "startIndex", feedInst.CurrentFeedIndex)

		data := baseData

		if err != nil {
			ac.Logger.Error("failed to query popular media", "error", err)
			errStr := err.Error()
			data.Error = &errStr
			templateExt.Respond(templ, feedSwiperSlides.TemplateName, data, w)
			return
		}

		data.FeedSwiper.Slides = make([]feedSwiperSlides.FeedSwiperSlide, len(media))

		for i, m := range media {
			data.FeedSwiper.Slides[i] = feedSwiperSlides.FromMedia(m, feedInst.CurrentFeedIndex+int64(i))
		}

		templateExt.Respond(templ, feedSwiperSlides.TemplateName, data, w)
	}
}
