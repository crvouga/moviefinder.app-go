package tmdbAPI

type Fixture struct {
	tmdbAPI *Client
}

func NewFixture() *Fixture {
	tmdbAPI := NewFromEnv()
	return &Fixture{
		tmdbAPI: tmdbAPI,
	}
}
