package apiDocsPage

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/ctx/reqCtx"
	"movieFinder/app/projects/project"
	"movieFinder/app/projects/projectRoutes"
	"movieFinder/app/users/userID"
	"net/http"
)

type ProjectIDSelect struct {
	Projects         []*project.Project
	CreateProjectURL string
	ProjectID        string
}

func GetProjectIDSelect(ac *appCtx.AppCtx, r *http.Request) ProjectIDSelect {
	rc := reqCtx.FromHttpRequest(ac, r)

	return ProjectIDSelect{
		Projects:         getProjects(ac, rc.UserSession.UserID),
		ProjectID:        r.URL.Query().Get("projectID"),
		CreateProjectURL: projectRoutes.ToCreateProject(),
	}
}

func getProjects(ac *appCtx.AppCtx, userID userID.UserID) []*project.Project {
	projects, err := ac.ProjectDB.GetByCreatedByUserID(userID)

	if err != nil {
		return []*project.Project{}
	}

	return projects
}
