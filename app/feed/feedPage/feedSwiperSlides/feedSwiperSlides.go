// Package feedSwiperSlides provides the feed swiper slides UI component
package feedSwiperSlides

import (
	"movieFinder/app/media"
	"movieFinder/app/routes"
	"movieFinder/lib/static"
)

type FeedSwiperSlide struct {
	ImageSrc        string
	PreloadImageSrc string
	URL             string
	FeedIndex       int64
}

var TemplateName = "feedSwiperSlides"
var TemplatePath = static.GetSiblingPath(TemplateName + ".html")

func FromMedia(m media.Media, feedIndex int64) FeedSwiperSlide {
	return FeedSwiperSlide{
		ImageSrc:        m.PosterURL,
		PreloadImageSrc: m.BackdropURL,
		URL:             routes.MediaPage(m.ID),
		FeedIndex:       feedIndex,
	}
}
