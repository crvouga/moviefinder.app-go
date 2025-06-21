// Package feedSwiperSlides provides the feed swiper slides UI component
package feedSwiperSlides

import (
	"movieFinder/app/media"
	"movieFinder/app/routes"
	"movieFinder/lib/static"
)

type FeedSwiperSlide struct {
	ImageSrc        string
	ImageAlt        string
	PreloadImageSrc string
	PreloadImageAlt string
	AriaLabel       string
	URL             string
	FeedIndex       int64
	SlideIndex      int64
}

var TemplateName = "feedSwiperSlides"
var TemplatePath = static.GetSiblingPath(TemplateName + ".html")

func FromMedia(m media.Media, feedIndex int64, slideIndex int64) FeedSwiperSlide {
	return FeedSwiperSlide{
		ImageSrc:        m.PosterURL,
		ImageAlt:        m.Title + " poster",
		PreloadImageSrc: m.BackdropURL,
		PreloadImageAlt: m.Title + " backdrop",
		AriaLabel:       m.Title + " open details",
		URL:             routes.MediaPage(m.ID),
		FeedIndex:       feedIndex,
		SlideIndex:      slideIndex,
	}
}
