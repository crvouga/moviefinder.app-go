// Package feedSwiperSlides provides the feed swiper slides UI component
package feedSwiperSlides

import (
	"movieFinder/app/media"
	"movieFinder/lib/static"
)

type FeedSwiperSlide struct {
	ImageSrc string
	URL      string
}

var TemplateName = "feedSwiperSlides"
var TemplatePath = static.GetSiblingPath(TemplateName + ".html")

func FromMedia(m media.Media) FeedSwiperSlide {
	return FeedSwiperSlide{
		ImageSrc: m.PosterURL,
		URL:      "",
	}
}
