package mediaDB

import (
	"database/sql"
	"log/slog"
	"movieFinder/lib/sqlite"
	"movieFinder/lib/tmdbAPI"
)

type Fixture struct {
	DB     *sql.DB
	Client *tmdbAPI.Client
}

func NewFixture() *Fixture {
	db, err := sqlite.New(":memory:")
	if err != nil {
		panic(err)
	}
	err = CreateTables(db, slog.Default())
	if err != nil {
		panic(err)
	}
	client, err := tmdbAPI.NewFromEnv()
	if err != nil {
		panic(err)
	}
	return &Fixture{
		DB:     db,
		Client: client,
	}
}
