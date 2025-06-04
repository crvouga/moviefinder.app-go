package textField

import "movieFinder/lib/static"

const TypeText = "text"
const TypeTel = "tel"

type Data struct {
	Label string
	Name  string
	Type  string
}

var TemplateName = "textField"
var TemplatePath = static.GetSiblingPath(TemplateName + ".html")
