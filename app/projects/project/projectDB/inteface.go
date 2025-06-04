package projectDB

import (
	"movieFinder/app/projects/project"
	"movieFinder/app/projects/project/projectID"
	"movieFinder/app/users/userID"
	"movieFinder/lib/uow"
)

type ProjectDB interface {
	GetByID(projectID projectID.ProjectID) (*project.Project, error)
	Upsert(uow *uow.Uow, project *project.Project) error
	GetByCreatedByUserID(createdByUserID userID.UserID) ([]*project.Project, error)
	ZapByID(uow *uow.Uow, projectID projectID.ProjectID) error
}
