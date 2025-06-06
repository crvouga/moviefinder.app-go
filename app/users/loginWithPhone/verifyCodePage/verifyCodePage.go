package verifyCodePage

import (
	"movieFinder/app/home/feedPage"
	"movieFinder/app/ui/button"
	"movieFinder/app/ui/document"
	"movieFinder/app/ui/templateExt"
	"movieFinder/app/ui/textField"
	"movieFinder/app/ui/topBar"
	"movieFinder/app/users/loginWithPhone/loginWithPhoneRoutes"
	"movieFinder/app/users/userAccount/userAccountRoutes"
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
	}
	templatePaths = append(templatePaths, button.TemplatePaths...)
	templ := templateExt.Combine(templatePaths)
	type Data struct {
		Document         document.Data
		TopBar           topBar.Data
		PhoneNumber      string
		TextFieldCode    textField.Data
		ButtonVerifyCode button.Data
		Error            string
	}
	baseData := Data{
		Document: document.Data{
			Preload: []document.Preload{
				document.NewPreload(userAccountRoutes.UserAccountPage),
				document.NewPreload(loginWithPhoneRoutes.SendCodePage),
			},
		},
		TopBar: topBar.Data{
			BackHref: loginWithPhoneRoutes.SendCodePage,
			Title:    "Verify Code",
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
				feedPage.Redirect(w, r)
				return
			}
			err := "Invalid code"
			Redirect(w, r, phoneNumber, &err)
			return
		}
		data := baseData
		data.PhoneNumber = r.URL.Query().Get("phoneNumber")
		data.Error = r.URL.Query().Get("error")
		templateExt.Respond(templ, document.TemplateName, data, w)
	}
}

func Redirect(w http.ResponseWriter, r *http.Request, phoneNumber string, err *string) {
	query := url.Values{}
	query.Set("phoneNumber", phoneNumber)
	if err != nil {
		query.Set("error", *err)
	}
	http.Redirect(w, r, loginWithPhoneRoutes.VerifyCodePage+"?"+query.Encode(), http.StatusFound)
}
