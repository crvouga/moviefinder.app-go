package sqlite

import (
	"database/sql"
	"log/slog"
	"os"
	"path/filepath"
	"time"

	_ "modernc.org/sqlite"
)

func New(dbPath string) (*sql.DB, error) {
	// Convert relative path to absolute from current working directory
	cwd, err := os.Getwd()
	if err != nil {
		slog.Error("Failed to get working directory", "error", err)
		return nil, err
	}
	absPath := filepath.Join(cwd, dbPath)

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

func LoadIntoMemory(loadDbPath string) (*sql.DB, error) {
	slog.Info("Loading SQLite database into memory", "path", loadDbPath)

	// Check if source file exists
	if _, err := os.Stat(loadDbPath); os.IsNotExist(err) {
		// Try looking in root directory
		slog.Error("Source database file does not exist", "path", loadDbPath)
		return nil, err
	}

	// Create in-memory database
	db, err := sql.Open("sqlite", ":memory:")
	if err != nil {
		slog.Error("Failed to create in-memory database", "error", err)
		return nil, err
	}

	// Open source database
	sourceDb, err := sql.Open("sqlite", loadDbPath)
	if err != nil {
		slog.Error("Failed to open source database", "path", loadDbPath, "error", err)
		return nil, err
	}
	defer sourceDb.Close()

	// Backup source database to memory
	slog.Debug("Copying database to memory")
	_, err = db.Exec("VACUUM INTO ?", loadDbPath)
	if err != nil {
		slog.Error("Failed to copy database to memory", "error", err)
		return nil, err
	}

	slog.Info("Successfully loaded database into memory")
	return db, nil
}
