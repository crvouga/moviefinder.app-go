package appDb

import (
	"log/slog"
	"movieFinder/lib/dotEnv"
	"movieFinder/lib/postgres"
	"os"
)

func GetDatabaseUrl() string {
	err := dotEnv.Load()
	if err != nil {
		panic(err)
	}
	databaseUrl := os.Getenv("DATABASE_URL")
	if databaseUrl == "" {
		panic("DATABASE_URL is not set")
	}
	return databaseUrl
}

func New(logger *slog.Logger) *postgres.Postgres {
	db, err := postgres.New(GetDatabaseUrl(), logger)
	if err != nil {
		panic(err)
	}
	return db
}
