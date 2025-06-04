package projects

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/projects/createProject"
	"movieFinder/app/projects/deleteProject"
	"movieFinder/app/projects/editProject"
	"movieFinder/app/projects/listProjects"
	"movieFinder/app/projects/projectPage"

	"net/http"
)

func Router(mux *http.ServeMux, ac *appCtx.AppCtx) {
	createProject.Router(mux, ac)
	editProject.Router(mux, ac)
	deleteProject.Router(mux, ac)
	listProjects.Router(mux, ac)
	projectPage.Router(mux, ac)
}
