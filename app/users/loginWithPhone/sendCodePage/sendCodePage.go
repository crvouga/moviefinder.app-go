package sendCodePage

import (
	"movieFinder/app/ui/document"
	"movieFinder/app/ui/templateExt"
	"movieFinder/app/users/loginWithPhone/loginWithPhoneRoutes"
	"movieFinder/lib/static"
	"net/http"
)

func Router(mux *http.ServeMux) {
	mux.HandleFunc(loginWithPhoneRoutes.SendCodePage, Respond())
}

func Respond() http.HandlerFunc {
	templatePaths := []string{
		static.GetSiblingPath("sendCodePage.html"),
		document.TemplatePath,
	}
	templ := templateExt.Combine(templatePaths)
	return func(w http.ResponseWriter, r *http.Request) {
		templateExt.Respond(templ, document.TemplateName, nil, w)
	}
}
