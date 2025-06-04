package sendEmail

import (
	"movieFinder/library/email/email"
	"movieFinder/library/uow"
)

type SendEmail interface {
	SendEmail(uow *uow.Uow, email email.Email) error
}
