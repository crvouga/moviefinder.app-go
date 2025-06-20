package sqlite

import (
	"database/sql"

	_ "modernc.org/sqlite"
)

func New(dbPath string) (*sql.DB, error) {
	db, err := sql.Open("sqlite", dbPath)
	if err != nil {
		return nil, err
	}

	// Enable WAL mode
	_, err = db.Exec("PRAGMA journal_mode=WAL;")
	if err != nil {
		return nil, err
	}

	// Set busy timeout to 5 seconds (5000 ms)
	_, err = db.Exec("PRAGMA busy_timeout = 5000;")
	if err != nil {
		return nil, err
	}

	// Set locking mode to EXCLUSIVE to prevent "database is locked" errors
	_, err = db.Exec("PRAGMA locking_mode=EXCLUSIVE;")
	if err != nil {
		return nil, err
	}

	// Enable foreign keys
	_, err = db.Exec("PRAGMA foreign_keys=ON;")
	if err != nil {
		return nil, err
	}

	// Set synchronous mode to NORMAL for better performance while maintaining safety
	_, err = db.Exec("PRAGMA synchronous=NORMAL;")
	if err != nil {
		return nil, err
	}

	return db, nil
}
