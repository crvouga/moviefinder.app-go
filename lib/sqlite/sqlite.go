package sqlite

import (
	"database/sql"
	"log/slog"
	"path/filepath"
	"time"

	_ "modernc.org/sqlite"
)

func New(dbPath string) (*sql.DB, error) {
	var absPath string

	if dbPath == ":memory:" {
		absPath = dbPath
	} else {
		// Convert to absolute path
		var err error
		absPath, err = filepath.Abs(dbPath)
		if err != nil {
			slog.Error("Failed to get absolute path", "error", err)
			return nil, err
		}
	}

	slog.Info("Opening SQLite database", "path", absPath)

	db, err := sql.Open("sqlite", absPath)
	if err != nil {
		slog.Error("Failed to open SQLite database", "path", absPath, "error", err)
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

	slog.Info("Successfully opened SQLite database", "path", absPath)
	return db, nil
}
