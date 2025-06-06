package sqlite

import (
	"database/sql"
	"log/slog"
	"path/filepath"
	"time"

	_ "modernc.org/sqlite"
)

func New(dbPath string) (*sql.DB, error) {
	var dsn string
	var isInMemory bool

	if dbPath == ":memory:" {
		// Use a named in-memory DB with shared cache
		dsn = "file:memdb1?mode=memory&cache=shared"
		isInMemory = true
	} else {
		// Convert to absolute path
		absPath, err := filepath.Abs(dbPath)
		if err != nil {
			slog.Error("Failed to get absolute path", "error", err)
			return nil, err
		}
		dsn = absPath
	}

	slog.Info("Opening SQLite database", "dsn", dsn)

	db, err := sql.Open("sqlite", dsn)
	if err != nil {
		slog.Error("Failed to open SQLite database", "dsn", dsn, "error", err)
		return nil, err
	}

	if isInMemory {
		// Force single connection for in-memory DB safety
		db.SetMaxOpenConns(1)
		db.SetMaxIdleConns(1)
	} else {
		db.SetMaxOpenConns(25)
		db.SetMaxIdleConns(10)
	}

	db.SetConnMaxLifetime(30 * time.Minute)

	// Apply PRAGMAs
	pragmas := []string{
		"PRAGMA journal_mode = WAL",
		"PRAGMA busy_timeout = 5000",
		"PRAGMA synchronous = NORMAL",
		"PRAGMA foreign_keys = ON",
		"PRAGMA temp_store = MEMORY",
		"PRAGMA mmap_size = 30000000000",
		"PRAGMA cache_size = -2000",
		"PRAGMA locking_mode = NORMAL",
		"PRAGMA read_uncommitted = 1",
	}

	slog.Debug("Setting SQLite pragmas")
	for _, pragma := range pragmas {
		if _, err := db.Exec(pragma); err != nil {
			slog.Error("Failed to set SQLite pragma", "pragma", pragma, "error", err)
			return nil, err
		}
	}

	slog.Info("Successfully opened SQLite database", "dsn", dsn)
	return db, nil
}
