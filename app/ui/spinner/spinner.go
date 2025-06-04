package spinner

import "movieFinder/lib/static"

type Data struct {
	Class string
}

var TemplateName = "spinner"
var TemplatePath = static.GetSiblingPath(TemplateName + ".html")
