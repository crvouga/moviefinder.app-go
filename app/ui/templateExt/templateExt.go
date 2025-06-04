package templateExt

import (
	"html/template"
	"net/http"
)

var FuncMap = template.FuncMap{
	"safeHTML": func(s string) template.HTML {
		return template.HTML(s)
	},
}

func Combine(templatePaths ...string) *template.Template {
	return template.Must(template.New("").Funcs(FuncMap).ParseFiles(
		templatePaths...,
	))
}

func Respond(template *template.Template, templateName string, data any, w http.ResponseWriter) {
	w.Header().Set("Content-Type", "text/html; charset=utf-8")
	err := template.ExecuteTemplate(w, templateName, data)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}
}
