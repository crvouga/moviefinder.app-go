// Package feedSwiperSlides provides the feed swiper slides UI component
package feedSwiperSlides

import (
	"movieFinder/lib/static"
)

type FeedSwiperSlide struct {
	ImageSrc string
	URL      string
}

var TemplateName = "feedSwiperSlides.html"
var TemplatePath = static.GetSiblingPath(TemplateName)
