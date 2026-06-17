package postgres

import (
	"database/sql"
	"log/slog"
	"time"

	_ "github.com/lib/pq"
)

type Postgres struct {
	DB          *sql.DB
	DatabaseURL string
	Logger      *slog.Logger
}

func New(databaseURL string, logger *slog.Logger) (*Postgres, error) {
	schemaURL, err := WithSchema(databaseURL)
	if err != nil {
		return nil, err
	}

	db, err := sql.Open("postgres", schemaURL)
	if err != nil {
		return nil, err
	}

	db.SetMaxOpenConns(25)
	db.SetMaxIdleConns(5)
	db.SetConnMaxLifetime(5 * time.Minute)

	if err := db.Ping(); err != nil {
		_ = db.Close()
		return nil, err
	}

	if err := EnsureSchema(db); err != nil {
		_ = db.Close()
		return nil, err
	}

	return &Postgres{
		DB:          db,
		DatabaseURL: schemaURL,
		Logger:      logger,
	}, nil
}
