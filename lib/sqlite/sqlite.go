package sqlite

import (
	"database/sql"

	"movieFinder/lib/sql/noop"
)

func New() *sql.DB {
	return noop.New()
}
