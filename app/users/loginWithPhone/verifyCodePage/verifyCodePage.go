package verifyCodePage

import (
	"movieFinder/app/home/homePage"
	"movieFinder/app/ui/button"
	"movieFinder/app/ui/document"
	"movieFinder/app/ui/templateExt"
	"movieFinder/app/ui/textField"
	"movieFinder/app/ui/topBar"
	"movieFinder/app/users/loginWithPhone/loginWithPhoneRoutes"
	"movieFinder/lib/static"
	"net/http"
	"net/url"
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
		Error            string
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
			code := r.FormValue(baseData.TextFieldCode.Name)
			phoneNumber := r.URL.Query().Get("phoneNumber")
			if code == "123" {
				homePage.Redirect(w, r)
				return
			}
			query := url.Values{}
			query.Set("phoneNumber", phoneNumber)
			query.Set("error", "Invalid code")
			http.Redirect(w, r, loginWithPhoneRoutes.VerifyCodePage+"?"+query.Encode(), http.StatusFound)
			return
		}
		data := baseData
		data.PhoneNumber = r.URL.Query().Get("phoneNumber")
		data.Error = r.URL.Query().Get("error")
		templateExt.Respond(templ, document.TemplateName, data, w)
	}
}

func Redirect(w http.ResponseWriter, r *http.Request, phoneNumber string) {
	query := url.Values{}
	query.Set("phoneNumber", phoneNumber)
	http.Redirect(w, r, loginWithPhoneRoutes.VerifyCodePage+"?"+query.Encode(), http.StatusFound)
}
