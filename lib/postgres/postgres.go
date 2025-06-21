package postgres

import (
	"database/sql"
	"log/slog"

	_ "github.com/lib/pq"
)

type Postgres struct {
	DB          *sql.DB
	DatabaseURL string
	Logger      *slog.Logger
}

func New(databaseURL string, logger *slog.Logger) (*Postgres, error) {
	db, err := sql.Open("postgres", databaseURL)

	if err != nil {
		return nil, err
	}

	err = db.Ping()
	if err != nil {
		return nil, err
	}

	return &Postgres{
		DB:          db,
		DatabaseURL: databaseURL,
		Logger:      logger,
	}, nil
}
