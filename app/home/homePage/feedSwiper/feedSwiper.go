// Package feedSwiper provides the bottom navigation buttons UI component
package feedSwiper

import "movieFinder/lib/static"

type FeedSwiper struct {
	Items []FeedSwiperItem
}

type FeedSwiperItem struct {
	ImageSrc string
	URL      string
}

var TemplatePath = static.GetSiblingPath("feedSwiper.html")
