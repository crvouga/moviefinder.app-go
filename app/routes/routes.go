package routes

const (
	MediaPagePath   = "/media"
	FeedPage        = "/feed"
	UserAccountPage = "/user-account-page"
)

func MediaPage(mediaID string) string {
	return MediaPagePath + "?mediaID=" + mediaID
}
