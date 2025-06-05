package tmdbAPI

type Fixture struct {
	tmdbAPI *TmdbAPI
}

func NewFixture() *Fixture {
	tmdbAPI := NewFromEnv()
	return &Fixture{
		tmdbAPI: tmdbAPI,
	}
}
