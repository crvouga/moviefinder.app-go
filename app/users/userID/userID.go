package userID

import "movieFinder/library/id"

type UserID string

func Gen() UserID {
	return UserID(id.Gen())
}

func New(id string) UserID {
	return UserID(id)
}
