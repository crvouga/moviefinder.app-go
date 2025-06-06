package tmdbAPI

import (
	"log/slog"
	"os"
)

type Fixture struct {
	tmdbAPI *Client
}

func NewFixture() *Fixture {
	logger := slog.New(slog.NewTextHandler(os.Stdout, nil))

	tmdbAPI, err := NewFromEnv(logger)

	if err != nil {
		panic(err)
	}
	return &Fixture{
		tmdbAPI: tmdbAPI,
	}
}
