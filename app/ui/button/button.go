package button

import "movieFinder/lib/static"

type Data struct {
	Text string
	Href string
}

var TemplateName = "button"
var TemplatePath = static.GetSiblingPath(TemplateName + ".html")
