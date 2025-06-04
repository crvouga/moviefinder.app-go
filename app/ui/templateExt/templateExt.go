package templateExt

import (
	"errors"
	"html/template"
	"net/http"
)

var FuncMap = template.FuncMap{
	"safeHTML": func(s string) template.HTML {
		return template.HTML(s)
	},
	"dict": func(values ...interface{}) (map[string]interface{}, error) {
		if len(values)%2 != 0 {
			return nil, errors.New("dict: number of values is not even")
		}
		dict := make(map[string]interface{}, len(values)/2)
		for i := 0; i < len(values); i += 2 {
			key, ok := values[i].(string)
			if !ok {
				return nil, errors.New("dict: key is not a string")
			}
			dict[key] = values[i+1]
		}
		return dict, nil
	},
}

func Combine(templatePaths []string) *template.Template {
	return template.Must(template.New("").Funcs(FuncMap).ParseFiles(templatePaths...))
}

func Respond(template *template.Template, templateName string, data any, w http.ResponseWriter) {
	w.Header().Set("Content-Type", "text/html; charset=utf-8")
	err := template.ExecuteTemplate(w, templateName, data)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}
}
