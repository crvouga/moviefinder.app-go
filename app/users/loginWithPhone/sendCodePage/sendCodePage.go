package sendCodePage

import (
	"movieFinder/app/ui/button"
	"movieFinder/app/ui/document"
	"movieFinder/app/ui/templateExt"
	"movieFinder/app/ui/textField"
	"movieFinder/app/ui/topBar"
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
		topBar.TemplatePath,
		textField.TemplatePath,
		button.TemplatePath,
	}
	templ := templateExt.Combine(templatePaths)
	return func(w http.ResponseWriter, r *http.Request) {
		type Data struct {
			TopBar               topBar.Data
			TextFieldPhoneNumber textField.Data
			ButtonSendCode       button.Data
		}
		data := Data{
			TopBar: topBar.Data{
				Title: "Send Code",
			},
			TextFieldPhoneNumber: textField.Data{
				Label: "Phone Number",
			},
			ButtonSendCode: button.Data{
				Text:  "Send Code",
				Class: "w-full",
			},
		}
		templateExt.Respond(templ, document.TemplateName, data, w)
	}
}
