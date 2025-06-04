package textField

import "movieFinder/lib/static"

type Data struct {
	Label string
}

var TemplateName = "textField"
var TemplatePath = static.GetSiblingPath(TemplateName + ".html")
