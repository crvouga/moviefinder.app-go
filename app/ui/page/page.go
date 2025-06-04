package page

import (
	"html/template"
	"movieFinder/lib/static"
	"net/http"
)

var FuncMap = template.FuncMap{
	"safeHTML": func(s string) template.HTML {
		return template.HTML(s)
	},
}

func Respond(pageData any, templatePaths ...string) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		allTemplatePaths := []string{
			static.GetSiblingPath("page.html"),
		}

		allTemplatePaths = append(allTemplatePaths, templatePaths...)

		tmpl, err := template.New("page.html").Funcs(FuncMap).ParseFiles(allTemplatePaths...)
		if err != nil {
			errStr := err.Error()
			http.Error(w, errStr, http.StatusInternalServerError)
			return
		}

		w.Header().Set("Content-Type", "text/html; charset=utf-8")

		if err := tmpl.ExecuteTemplate(w, "page.html", pageData); err != nil {
			errStr := err.Error()
			http.Error(w, errStr, http.StatusInternalServerError)
		}
	}
}

var TemplatePath = static.GetSiblingPath("page.html")
