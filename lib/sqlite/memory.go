package sqlite

import (
	"database/sql"
	"log/slog"
	"os"
)

func LoadIntoMemory(loadDbPath string) (*sql.DB, error) {
	slog.Info("Loading SQLite schema into memory", "path", loadDbPath)

	// Check if source file exists
	if _, err := os.Stat(loadDbPath); os.IsNotExist(err) {
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

	// Get all schema definitions from the source database
	rows, err := sourceDb.Query(`
		SELECT sql FROM sqlite_master 
		WHERE type IN ('table', 'view', 'index', 'trigger')
		AND name NOT LIKE 'sqlite_%'
	`)
	if err != nil {
		slog.Error("Failed to query schema information", "error", err)
		return nil, err
	}
	defer rows.Close()

	// Execute each schema definition in the memory database
	for rows.Next() {
		var sqlStmt string
		if err := rows.Scan(&sqlStmt); err != nil {
			slog.Error("Failed to scan schema definition", "error", err)
			return nil, err
		}

		if _, err := db.Exec(sqlStmt); err != nil {
			slog.Error("Failed to execute schema statement", "statement", sqlStmt, "error", err)
			return nil, err
		}
	}

	// Check for any errors during iteration
	if err := rows.Err(); err != nil {
		slog.Error("Error during schema iteration", "error", err)
		return nil, err
	}

	slog.Info("Successfully loaded schema into memory")
	return db, nil
}
