package tmdbAPI

type Fixture struct {
	tmdbAPI *Client
}

func NewFixture() *Fixture {
	tmdbAPI, err := NewFromEnv()
	if err != nil {
		panic(err)
	}
	return &Fixture{
		tmdbAPI: tmdbAPI,
	}
}
