package feed

type Feed struct {
	ID               string
	CurrentFeedIndex int64
	CreatedAtEpoch   int64
	UpdatedAtEpoch   int64
}
