package mediaDB

import (
	"database/sql"
	_ "embed"
	"fmt"
	"strconv"
)

//go:embed insertMedia.sql
var insertMediaSQL string

type InsertMedia struct {
	stmt *sql.Stmt
}

func NewInsertMedia(db *sql.DB) (*InsertMedia, error) {
	stmt, err := db.Prepare(insertMediaSQL)
	if err != nil {
		return nil, err
	}
	return &InsertMedia{stmt: stmt}, nil
}

func (i *InsertMedia) Close() error {
	return i.stmt.Close()
}

type InsertMediaDTO struct {
	ID          int
	Title       string
	Overview    string
	Popularity  float64
	ReleaseDate string
	VoteAverage float64
	VoteCount   int
	Runtime     int
	Adult       bool
}

func (i *InsertMedia) Execute(tx *sql.Tx, media InsertMediaDTO) error {
	_, err := tx.Stmt(i.stmt).Exec(
		strconv.FormatInt(int64(media.ID), 10),
		media.Title,
		media.Overview,
		media.Popularity,
		media.ReleaseDate,
		media.VoteAverage,
		media.VoteCount,
		media.Runtime,
		media.Adult,
	)
	if err != nil {
		return fmt.Errorf("failed to insert movie: %v", err)
	}
	return nil
}
