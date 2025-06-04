package verifyCodePage

import (
	"fmt"
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
	mux.HandleFunc(loginWithPhoneRoutes.VerifyCodePage, Respond())
}

func Respond() http.HandlerFunc {
	templatePaths := []string{
		static.GetSiblingPath("verifyCodePage.html"),
		document.TemplatePath,
		topBar.TemplatePath,
		textField.TemplatePath,
		button.TemplatePath,
	}
	templ := templateExt.Combine(templatePaths)
	type Data struct {
		TopBar           topBar.Data
		PhoneNumber      string
		TextFieldCode    textField.Data
		ButtonVerifyCode button.Data
	}
	baseData := Data{
		TopBar: topBar.Data{
			Title: "Verify Code",
		},
		TextFieldCode: textField.Data{
			Label: "Code",
			Name:  "code",
			Type:  textField.TypeTel,
		},
		ButtonVerifyCode: button.Data{
			Text:  "Verify Code",
			Class: "w-full",
		},
	}
	return func(w http.ResponseWriter, r *http.Request) {
		if r.Method == "POST" {
			phoneNumber := r.FormValue(baseData.TextFieldCode.Name)
			fmt.Println(phoneNumber)
			http.Redirect(w, r, loginWithPhoneRoutes.VerifyCodePage, http.StatusFound)
			return
		}
		data := baseData
		data.PhoneNumber = r.URL.Query().Get("phoneNumber")
		templateExt.Respond(templ, document.TemplateName, data, w)
	}
}

func Redirect(w http.ResponseWriter, r *http.Request, phoneNumber string) {
	http.Redirect(w, r, loginWithPhoneRoutes.VerifyCodePage+"?phoneNumber="+phoneNumber, http.StatusFound)
}
