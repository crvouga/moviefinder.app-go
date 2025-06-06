package routes

const (
	MediaPagePath = "/media"
)

func MediaPage(mediaID string) string {
	return MediaPagePath + "?mediaID=" + mediaID
}
