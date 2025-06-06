package sqlite

import (
	"database/sql"
	"log/slog"
	"time"

	_ "modernc.org/sqlite"
)

func New(dbPath string) (*sql.DB, error) {
	slog.Info("Opening SQLite database", "path", dbPath)

	db, err := sql.Open("sqlite", dbPath)
	if err != nil {
		slog.Error("Failed to open SQLite database", "path", dbPath, "error", err)
		return nil, err
	}

	// Enable recommended pragmas for better performance and safety
	pragmas := []string{
		"PRAGMA journal_mode = WAL",      // Write-Ahead Logging for better concurrency
		"PRAGMA busy_timeout = 5000",     // Wait up to 5s when database is locked
		"PRAGMA synchronous = NORMAL",    // Balance between safety and performance
		"PRAGMA foreign_keys = ON",       // Enforce data integrity
		"PRAGMA temp_store = MEMORY",     // Store temp tables in memory
		"PRAGMA mmap_size = 30000000000", // Memory-map up to 30GB of database file
		"PRAGMA cache_size = -2000",      // Use 2MB of memory for page cache
		"PRAGMA locking_mode = NORMAL",   // Allow multiple readers
		"PRAGMA read_uncommitted = 1",    // Enable read uncommitted isolation for better concurrency
	}

	slog.Debug("Setting SQLite pragmas")
	for _, pragma := range pragmas {
		_, err = db.Exec(pragma)
		if err != nil {
			slog.Error("Failed to set SQLite pragma", "pragma", pragma, "error", err)
			return nil, err
		}
	}

	// Set connection pool settings
	slog.Debug("Configuring connection pool")
	db.SetMaxOpenConns(25)                  // Maximum number of open connections
	db.SetMaxIdleConns(10)                  // Maximum number of idle connections
	db.SetConnMaxLifetime(30 * time.Minute) // Maximum lifetime of a connection

	slog.Info("Successfully opened SQLite database", "path", dbPath)
	return db, nil
}

func LoadIntoMemory(loadDbPath string) (*sql.DB, error) {
	slog.Info("Loading SQLite database into memory", "path", loadDbPath)

	db, err := sql.Open("sqlite", ":memory:")
	if err != nil {
		slog.Error("Failed to create in-memory database", "error", err)
		return nil, err
	}

	sourceDb, err := sql.Open("sqlite", loadDbPath)
	if err != nil {
		slog.Error("Failed to open source database", "path", loadDbPath, "error", err)
		return nil, err
	}
	defer sourceDb.Close()

	slog.Debug("Vacuuming source database")
	_, err = sourceDb.Exec("VACUUM")
	if err != nil {
		slog.Error("Failed to vacuum source database", "error", err)
		return nil, err
	}

	slog.Debug("Attaching source database")
	_, err = db.Exec("ATTACH DATABASE ? AS source", loadDbPath)
	if err != nil {
		slog.Error("Failed to attach source database", "error", err)
		return nil, err
	}

	slog.Debug("Copying schema from source database")
	_, err = db.Exec("SELECT sql FROM source.sqlite_master WHERE sql NOT NULL AND type='table'")
	if err != nil {
		slog.Error("Failed to copy schema from source database", "error", err)
		return nil, err
	}

	slog.Debug("Detaching source database")
	_, err = db.Exec("DETACH DATABASE source")
	if err != nil {
		slog.Error("Failed to detach source database", "error", err)
		return nil, err
	}

	slog.Info("Successfully loaded database into memory")
	return db, nil
}
