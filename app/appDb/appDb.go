package appDb

import (
	"database/sql"
	"log/slog"
	"movieFinder/lib/sqlite"
)

const DB_PATH = "./db/db.sqlite"

func OpenInMemory() *sql.DB {
	db, err := sqlite.LoadIntoMemory(DB_PATH)
	if err != nil {
		slog.Error("Failed to open in memory database", "error", err)
		panic(err)
	}
	return db
}

func OpenDurable() *sql.DB {
	db, err := sqlite.New(DB_PATH)
	if err != nil {
		panic(err)
	}
	return db
}
