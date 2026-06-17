package postgres

import (
	"database/sql"
	"fmt"
	"net/url"
)

// WithSchema returns a copy of databaseURL scoped to SchemaName via search_path.
// lib/pq only applies search_path from the options startup parameter, not the URL query key.
func WithSchema(databaseURL string) (string, error) {
	u, err := url.Parse(databaseURL)
	if err != nil {
		return "", err
	}
	q := u.Query()
	q.Set("search_path", SchemaName)

	opt := fmt.Sprintf("-csearch_path=%s", SchemaName)
	if existing := q.Get("options"); existing != "" {
		opt = existing + " " + opt
	}
	q.Set("options", opt)

	u.RawQuery = q.Encode()
	return u.String(), nil
}

// EnsureSchema creates the application schema if it does not exist.
func EnsureSchema(db *sql.DB) error {
	_, err := db.Exec(fmt.Sprintf("CREATE SCHEMA IF NOT EXISTS %s", SchemaName))
	return err
}
