package sqlite

import (
	"database/sql"
	"time"

	_ "modernc.org/sqlite"
)

func New(dbPath string) (*sql.DB, error) {
	db, err := sql.Open("sqlite", dbPath)
	if err != nil {
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

	for _, pragma := range pragmas {
		_, err = db.Exec(pragma)
		if err != nil {
			return nil, err
		}
	}

	// Set connection pool settings
	db.SetMaxOpenConns(25)                  // Maximum number of open connections
	db.SetMaxIdleConns(10)                  // Maximum number of idle connections
	db.SetConnMaxLifetime(30 * time.Minute) // Maximum lifetime of a connection

	return db, nil
}
