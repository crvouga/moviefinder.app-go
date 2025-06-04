package topBar

import "movieFinder/lib/static"

type Data struct {
	Title    string
	BackHref string
}

var TemplateName = "topBar"
var TemplatePath = static.GetSiblingPath(TemplateName + ".html")
