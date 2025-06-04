package sendCodePage

import (
	"movieFinder/app/ui/button"
	"movieFinder/app/ui/document"
	"movieFinder/app/ui/templateExt"
	"movieFinder/app/ui/textField"
	"movieFinder/app/ui/topBar"
	"movieFinder/app/users/loginWithPhone/loginWithPhoneRoutes"
	"movieFinder/app/users/loginWithPhone/verifyCodePage"
	"movieFinder/lib/static"
	"net/http"
	"time"
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
	}
	templatePaths = append(templatePaths, button.TemplatePaths...)
	templ := templateExt.Combine(templatePaths)
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
			Name:  "phoneNumber",
			Type:  textField.TypeTel,
		},
		ButtonSendCode: button.Data{
			Text:  "Send Code",
			Class: "w-full",
			Type:  button.TypeSubmit,
		},
	}
	return func(w http.ResponseWriter, r *http.Request) {
		if r.Method == "POST" {
			phoneNumber := r.FormValue(data.TextFieldPhoneNumber.Name)
			time.Sleep(2 * time.Second)
			verifyCodePage.Redirect(w, r, phoneNumber, nil)
			return
		}
		templateExt.Respond(templ, document.TemplateName, data, w)
	}
}
