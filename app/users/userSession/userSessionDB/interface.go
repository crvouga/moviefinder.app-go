package userSessionDB

import (
	"movieFinder/app/users/userSession"
	"movieFinder/library/sessionID"
	"movieFinder/library/uow"
)

type UserSessionDB interface {
	GetBySessionID(id sessionID.SessionID) (*userSession.UserSession, error)
	Upsert(uow *uow.Uow, userSession userSession.UserSession) error
	ZapBySessionID(uow *uow.Uow, sessionID sessionID.SessionID) error
}
