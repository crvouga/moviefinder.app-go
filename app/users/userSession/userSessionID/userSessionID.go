package userSessionID

import "movieFinder/library/id"

type UserSessionID string

func Gen() UserSessionID {
	return UserSessionID(id.Gen())
}
