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

	// Enable recommended pragmas for better performance and safety
	pragmas := []string{
		// "PRAGMA foreign_keys = ON",
		// "PRAGMA journal_mode = WAL",
		// "PRAGMA synchronous = NORMAL",
		// "PRAGMA temp_store = MEMORY",
		// "PRAGMA mmap_size = 30000000000",
		// "PRAGMA cache_size = -2000",
		// "PRAGMA busy_timeout = 5000",
	}

	for _, pragma := range pragmas {
		_, err = db.Exec(pragma)
		if err != nil {
			return nil, err
		}
	}

	return db, nil
}
