package appDb

import (
	"database/sql"
	"io"
	"log/slog"
	"movieFinder/db"
	"movieFinder/lib/sqlite"
)

const DbPath = "./db/db.sqlite"
const DbUrl = "sqlite:" + DbPath

func OpenDurable() *sql.DB {
	db, err := sqlite.New(DbPath)
	if err != nil {
		panic(err)
	}
	return db
}

func OpenInMemory() *sql.DB {
	dbInstance, err := sqlite.New(":memory:")
	if err != nil {
		slog.Error("Failed to open in memory database", "error", err)
		panic(err)
	}

	schema, err := db.SchemaFs.Open("schema.sql")
	if err != nil {
		slog.Error("Failed to read schema file", "error", err)
		panic(err)
	}

	schemaBytes, err := io.ReadAll(schema)
	if err != nil {
		slog.Error("Failed to read schema file", "error", err)
		panic(err)
	}

	_, err = dbInstance.Exec(string(schemaBytes))
	if err != nil {
		slog.Error("Failed to execute schema", "error", err)
		panic(err)
	}

	return dbInstance
}
