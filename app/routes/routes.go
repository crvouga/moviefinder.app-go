package routes

const (
	MEDIA_PAGE   = "/media"
	FEED_PAGE    = "/feed"
	USER_ACCOUNT = "/user-account"
	SEND_CODE    = "/send-code"
	VERIFY_CODE  = "/verify-code"
)

func MediaPage(mediaID string) string {
	return MEDIA_PAGE + "?mediaID=" + mediaID
}
