package sqlite

import (
	"database/sql"

	_ "modernc.org/sqlite"
)

func New(dbPath string) (*sql.DB, error) {
	return sql.Open("sqlite", dbPath)
}
