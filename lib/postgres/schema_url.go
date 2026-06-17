package postgres

import (
	"database/sql"
	"fmt"
	"net/url"
)

// WithSchema returns a copy of databaseURL with search_path set to SchemaName only.
func WithSchema(databaseURL string) (string, error) {
	u, err := url.Parse(databaseURL)
	if err != nil {
		return "", err
	}
	q := u.Query()
	q.Set("search_path", SchemaName)
	u.RawQuery = q.Encode()
	return u.String(), nil
}

// EnsureSchema creates the application schema if it does not exist.
func EnsureSchema(db *sql.DB) error {
	_, err := db.Exec(fmt.Sprintf("CREATE SCHEMA IF NOT EXISTS %s", SchemaName))
	return err
}
