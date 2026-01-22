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
	db, err := sql.Open("postgres", databaseURL)

	if err != nil {
		return nil, err
	}

	// Configure connection pool to prevent connection leaks
	// MaxOpenConns: maximum number of open connections to the database
	db.SetMaxOpenConns(25)
	// MaxIdleConns: maximum number of connections in the idle connection pool
	db.SetMaxIdleConns(5)
	// ConnMaxLifetime: maximum amount of time a connection may be reused
	db.SetConnMaxLifetime(5 * time.Minute)

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
