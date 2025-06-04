package loginCTA

import (
	"movieFinder/app/ui/button"
	"movieFinder/lib/static"
)

type Data struct {
	LoginButton button.Data
}

var TemplateName = "loginCTA.html"
var TemplatePath = static.GetSiblingPath(TemplateName)

var TemplatePaths = []string{
	TemplatePath,
	button.TemplatePath,
}
