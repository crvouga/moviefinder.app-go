package appDb

import (
	"database/sql"
	"movieFinder/lib/sqlite"
)

const DB_PATH = "db/db.sqlite"

func OpenInMemory() *sql.DB {
	db, err := sqlite.LoadIntoMemory(DB_PATH)
	if err != nil {
		panic(err)
	}
	return db
}

func Open() *sql.DB {
	db, err := sqlite.New(DB_PATH)
	if err != nil {
		panic(err)
	}
	return db
}
