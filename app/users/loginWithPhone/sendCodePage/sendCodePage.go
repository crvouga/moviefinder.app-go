package sendCodePage

import (
	"movieFinder/app/routes"
	"movieFinder/app/ui/button"
	"movieFinder/app/ui/document"
	"movieFinder/app/ui/templateExt"
	"movieFinder/app/ui/textField"
	"movieFinder/app/ui/topBar"
	"movieFinder/app/users/loginWithPhone/verifyCodePage"
	"movieFinder/lib/static"
	"net/http"
	"net/url"
	"strings"
	"time"
)

func Router(mux *http.ServeMux) {
	mux.HandleFunc(routes.SEND_CODE, Respond())
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
		Document             document.Data
		TopBar               topBar.Data
		TextFieldPhoneNumber textField.Data
		ButtonSendCode       button.Data
	}
	data := Data{
		Document: document.Data{
			Preload: []document.Preload{
				document.NewPreload(routes.USER_ACCOUNT),
				document.NewPreload(routes.VERIFY_CODE),
			},
		},
		TopBar: topBar.Data{
			Title:    "Send Code",
			BackHref: routes.USER_ACCOUNT,
		},
		TextFieldPhoneNumber: textField.Data{
			Label: "Phone Number",
			Name:  "phoneNumber",
			Type:  textField.TypeTel,
			Error: nil,
		},
		ButtonSendCode: button.Data{
			Text:  "Send Code",
			Class: "w-full",
			Type:  button.TypeSubmit,
		},
	}
	return func(w http.ResponseWriter, r *http.Request) {
		if r.Method == "POST" {
			phoneNumberDirty := r.FormValue(data.TextFieldPhoneNumber.Name)
			phoneNumber := strings.ReplaceAll(phoneNumberDirty, " ", "")
			if phoneNumber == "" {
				err := "Phone number is required"
				Redirect(w, r, phoneNumber, &err)
				return
			}
			time.Sleep(2 * time.Second)
			verifyCodePage.Redirect(w, r, phoneNumber, nil)
			return
		}
		templateExt.Respond(templ, document.TemplateName, data, w)
	}
}

func Redirect(w http.ResponseWriter, r *http.Request, phoneNumber string, err *string) {
	query := url.Values{}
	query.Set("phoneNumber", phoneNumber)
	if err != nil {
		query.Set("error", *err)
	}
	http.Redirect(w, r, routes.SEND_CODE+"?"+query.Encode(), http.StatusFound)
}
