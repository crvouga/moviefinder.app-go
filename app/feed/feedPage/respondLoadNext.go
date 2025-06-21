package feedPage

import (
	"fmt"
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/ctx/reqCtx"
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
		rc := reqCtx.FromHttpRequest(ac, r)

		rc.Logger.Info("handling load next request")

		startingFeedIndex := r.URL.Query().Get("startingFeedIndex")
		if startingFeedIndex == "" {
			rc.Logger.Error("missing startingFeedIndex query param")
			data := baseData
			errStr := "missing startingFeedIndex"
			data.Error = &errStr
			templateExt.Respond(templ, feedSwiperSlides.TemplateName, data, w)
			return
		}

		startingFeedIndexInt := 0
		_, err := fmt.Sscanf(startingFeedIndex, "%d", &startingFeedIndexInt)
		if err != nil {
			rc.Logger.Error("invalid startingFeedIndex", "error", err)
			data := baseData
			errStr := "invalid startingFeedIndex"
			data.Error = &errStr
			templateExt.Respond(templ, feedSwiperSlides.TemplateName, data, w)
			return
		}

		media, err := queryPopularMedia.Query(FEED_SLIDE_BATCH_SIZE, startingFeedIndexInt+FEED_SLIDE_BATCH_SIZE)

		rc.Logger.Debug("queried popular media", "count", len(media), "startIndex", startingFeedIndexInt)

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
			data.FeedSwiper.Slides[i] = feedSwiperSlides.FromMedia(m, int64(startingFeedIndexInt+i), int64(i))
		}

		templateExt.Respond(templ, feedSwiperSlides.TemplateName, data, w)
	}
}
