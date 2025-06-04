package document

import (
	"html/template"
	"movieFinder/lib/static"
)

var FuncMap = template.FuncMap{
	"safeHTML": func(s string) template.HTML {
		return template.HTML(s)
	},
}

var TemplateName = "document.html"
var TemplatePath = static.GetSiblingPath(TemplateName)
