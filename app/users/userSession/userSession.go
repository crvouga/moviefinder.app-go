package userSession

import (
	"movieFinder/app/users/userID"
	"movieFinder/app/users/userSession/userSessionID"
	"movieFinder/library/sessionID"
	"time"
)

type UserSession struct {
	ID        userSessionID.UserSessionID
	UserID    userID.UserID
	SessionID sessionID.SessionID
	CreatedAt time.Time
	EndedAt   time.Time
}
