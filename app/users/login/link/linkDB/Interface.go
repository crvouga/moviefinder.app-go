package linkDB

import (
	"movieFinder/app/users/login/link"
	"movieFinder/app/users/login/link/linkID"
	"movieFinder/lib/sessionID"
	"movieFinder/lib/uow"
)

type LinkDB interface {
	GetByLinkID(id linkID.LinkID) (*link.Link, error)
	GetBySessionID(sessionID sessionID.SessionID) ([]*link.Link, error)
	Upsert(uow *uow.Uow, link link.Link) error
}
