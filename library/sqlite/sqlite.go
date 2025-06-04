package sqlite

import (
	"database/sql"

	"movieFinder/library/sql/noop"
)

func New() *sql.DB {
	return noop.New()
}
