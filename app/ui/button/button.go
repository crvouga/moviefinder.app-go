package button

import (
	"movieFinder/app/ui/spinner"
	"movieFinder/lib/static"
)

const TypeSubmit = "submit"
const TypeButton = "button"

type Data struct {
	Text  string
	Href  string
	Class string
	Type  string
}

var TemplateName = "button"
var TemplatePath = static.GetSiblingPath(TemplateName + ".html")
var TemplatePaths = []string{
	TemplatePath,
	spinner.TemplatePath,
}
