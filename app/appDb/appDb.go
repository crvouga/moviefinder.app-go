package appDb

import (
	"database/sql"
	"fmt"
	"io"
	"log/slog"
	"movieFinder/db"
	"movieFinder/lib/dotEnv"
	"movieFinder/lib/postgres"
	"movieFinder/lib/sqlite"
	"os"
)

func getDatabaseUrl() string {
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

func OpenDurable() *sql.DB {
	db, err := postgres.New(getDatabaseUrl())
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

	err = validateSchema(dbInstance)
	if err != nil {
		slog.Error("Failed to validate schema", "error", err)
		panic(err)
	}

	return dbInstance
}

func validateSchema(db *sql.DB) error {
	rows, err := db.Query("SELECT name FROM sqlite_master WHERE type='table' AND name='media'")
	if err != nil {
		return err
	}
	defer rows.Close()

	if !rows.Next() {
		return fmt.Errorf("media table does not exist")
	}

	return nil
}
