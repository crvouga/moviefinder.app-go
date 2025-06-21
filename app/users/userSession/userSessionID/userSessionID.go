package userSessionID

import "movieFinder/lib/id"

type UserSessionID string

func Gen() UserSessionID {
	return UserSessionID(id.Gen("user_session", 16))
}
