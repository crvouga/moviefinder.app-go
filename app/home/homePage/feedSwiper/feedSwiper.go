// Package feedSwiper provides the bottom navigation buttons UI component
package feedSwiper

import (
	"html/template"
	"movieFinder/lib/static"
)

type FeedSwiper struct {
	Slides []FeedSwiperSlide
}

type FeedSwiperSlide struct {
	ImageSrc string
	URL      string
}

var TemplatePath = static.GetSiblingPath("feedSwiper.html")

var TemplatePathSwiperSlides = static.GetSiblingPath("feedSwiperSlides.html")

var Templates = template.Must(template.ParseFiles(
	TemplatePath,
	TemplatePathSwiperSlides,
))
