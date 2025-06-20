package feedPage

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/ctx/reqCtx"
	"movieFinder/app/feed/feedPage/feedSwiper"
	"movieFinder/app/feed/feedPage/feedSwiperSlides"
	"movieFinder/app/feed/feedRepo"
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
		rc := reqCtx.FromHttpRequest(ac, r)

		rc.Logger.Info("handling load next request")

		feed_, err := feedRepo.GetElseInsertBySessionID(ac.DB, rc.SessionID.String(), rc.Logger)

		if err != nil {
			rc.Logger.Error("failed to get/insert feed", "error", err, "sessionID", rc.SessionID.String())
		}

		rc.Logger.Debug("got feed instance", "feedID", feed_.ID, "currentIndex", feed_.CurrentFeedIndex)

		media, err := queryPopularMedia.Query(FEED_SLIDE_BATCH_SIZE, int(feed_.CurrentFeedIndex))

		rc.Logger.Debug("queried popular media", "count", len(media), "startIndex", feed_.CurrentFeedIndex)

		data := baseData

		if err != nil {
			rc.Logger.Error("failed to query popular media", "error", err)

			errStr := err.Error()

			data.Error = &errStr

			templateExt.Respond(templ, feedSwiperSlides.TemplateName, data, w)
			return
		}

		data.FeedSwiper.Slides = make([]feedSwiperSlides.FeedSwiperSlide, len(media))

		for i, m := range media {
			data.FeedSwiper.Slides[i] = feedSwiperSlides.FromMedia(m, feed_.CurrentFeedIndex+int64(i))
		}

		templateExt.Respond(templ, feedSwiperSlides.TemplateName, data, w)
	}
}
