package feedPage

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/feed/feedPage/feedSwiper"
	"movieFinder/app/feed/feedPage/feedSwiperSlides"
	"movieFinder/app/media/mediaDB"
	"movieFinder/app/ui/templateExt"
	"net/http"
)

func respondLoadNext(ac *appCtx.AppCtx) http.HandlerFunc {
	templ := templateExt.Combine([]string{
		feedSwiperSlides.TemplatePath,
	})
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
		panic(err)
	}

	return func(w http.ResponseWriter, r *http.Request) {
		media, err := queryPopularMedia.Query(10, 0)
		data := baseData
		if err != nil {
			errStr := err.Error()
			data.Error = &errStr
			templateExt.Respond(templ, feedSwiperSlides.TemplateName, data, w)
			return
		}
		data.FeedSwiper.Slides = make([]feedSwiperSlides.FeedSwiperSlide, len(media))
		for i, m := range media {
			data.FeedSwiper.Slides[i] = feedSwiperSlides.FromMedia(m)
		}
		templateExt.Respond(templ, feedSwiperSlides.TemplateName, data, w)
	}
}
