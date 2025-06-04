package loginCTA

import (
	"movieFinder/app/ui/button"
	"movieFinder/lib/static"
)

type Data struct {
	IconHTML    string
	LoginButton button.Data
}

var IconSize = "size-24"

var TemplateName = "loginCTA.html"
var TemplatePath = static.GetSiblingPath(TemplateName)

var TemplatePaths = []string{
	TemplatePath,
	button.TemplatePath,
}
