package mediaDB

import (
	"database/sql"
	"log/slog"
	"movieFinder/app/appDB"
	"movieFinder/lib/tmdbAPI"
)

type Fixture struct {
	DB     *sql.DB
	Client *tmdbAPI.Client
}

func NewFixture() *Fixture {
	postgres := appDB.New(slog.Default())

	client, err := tmdbAPI.NewFromEnv(slog.Default())
	if err != nil {
		panic(err)
	}
	return &Fixture{
		DB:     postgres.DB,
		Client: client,
	}
}
