// Package feedSwiper provides the bottom navigation buttons UI component
package feedSwiper

import (
	"movieFinder/app/feed/feedPage/feedSwiperSlides"
	"movieFinder/lib/static"
)

type FeedSwiper struct {
	Slides []feedSwiperSlides.FeedSwiperSlide
}

var TemplateName = "feedSwiper.html"
var TemplatePath = static.GetSiblingPath(TemplateName)

var TemplatePaths = []string{
	TemplatePath,
	feedSwiperSlides.TemplatePath,
}
