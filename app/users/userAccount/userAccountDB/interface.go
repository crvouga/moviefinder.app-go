package userAccountDB

import (
	"movieFinder/app/users/userAccount"
	"movieFinder/app/users/userAccount/userRole"
	"movieFinder/app/users/userID"
	"movieFinder/library/email/emailAddress"
	"movieFinder/library/uow"
)

type UserAccountDB interface {
	GetByUserID(id userID.UserID) (*userAccount.UserAccount, error)
	GetByEmailAddress(emailAddress emailAddress.EmailAddress) (*userAccount.UserAccount, error)
	GetByRole(role userRole.Role) ([]*userAccount.UserAccount, error)
	Upsert(uow *uow.Uow, userAccount userAccount.UserAccount) error
}
