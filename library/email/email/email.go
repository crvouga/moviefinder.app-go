package email

import (
	"movieFinder/library/email/emailAddress"
)

type Email struct {
	To      emailAddress.EmailAddress
	From    emailAddress.EmailAddress
	Subject string
	Body    string
}
