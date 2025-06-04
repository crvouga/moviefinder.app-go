// Package bottomButtons provides the bottom navigation buttons UI component
package bottomButtons

import "movieFinder/lib/static"

type BottomButtons struct {
	Items []BottomButtonsItem
}

type BottomButtonsItem struct {
	Label    string
	URL      string
	Active   bool
	IconHTML string
}

var TemplatePath = static.GetSiblingPath("bottomButtons.html")

const IconSize = "size-7"
