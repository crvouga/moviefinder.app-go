package mediaDB

import (
	"database/sql"
	"log/slog"
	appDb "movieFinder/app/db"
	"movieFinder/lib/sqlite"
	"movieFinder/lib/tmdbAPI"
)

type Fixture struct {
	DB     *sql.DB
	Client *tmdbAPI.Client
}

func NewFixture() *Fixture {
	db, err := sqlite.LoadIntoMemory(appDb.DB_PATH)

	if err != nil {
		panic(err)
	}

	client, err := tmdbAPI.NewFromEnv(slog.Default())
	if err != nil {
		panic(err)
	}
	return &Fixture{
		DB:     db,
		Client: client,
	}
}
