package document

import (
	"movieFinder/lib/static"
)

type Data struct {
	Preload []Preload
}

type Preload struct {
	Href string
}

// https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/rel/prefetch
func NewPreload(href string) Preload {
	return Preload{
		Href: href,
	}
}

var TemplateName = "document.html"
var TemplatePath = static.GetSiblingPath(TemplateName)
