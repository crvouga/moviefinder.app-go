package userSession

import (
	"movieFinder/app/users/userID"
	"movieFinder/app/users/userSession/userSessionID"
	"movieFinder/lib/sessionID"
	"time"
)

type UserSession struct {
	ID        userSessionID.UserSessionID
	UserID    userID.UserID
	SessionID sessionID.SessionID
	CreatedAt time.Time
	EndedAt   time.Time
}
