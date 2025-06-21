package userID

import "movieFinder/lib/id"

type UserID string

func Gen() UserID {
	return UserID(id.Gen("user", 16))
}

func New(id string) UserID {
	return UserID(id)
}
