package sendEmail

import (
	"movieFinder/lib/email/email"
	"movieFinder/lib/uow"
)

type SendEmail interface {
	SendEmail(uow *uow.Uow, email email.Email) error
}
