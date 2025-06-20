package mediaDB

import (
	"database/sql"
	_ "embed"
	"fmt"
	"strconv"
)

//go:embed insertMediaGenre.sql
var insertMediaGenreSQL string

type InsertMediaGenre struct {
	stmt *sql.Stmt
}

func NewInsertMediaGenre(db *sql.DB) (*InsertMediaGenre, error) {
	stmt, err := db.Prepare(insertMediaGenreSQL)
	if err != nil {
		return nil, err
	}
	return &InsertMediaGenre{stmt: stmt}, nil
}

func (i *InsertMediaGenre) Close() error {
	return i.stmt.Close()
}

func (i *InsertMediaGenre) Execute(tx *sql.Tx, movieID int, genreID int) error {
	_, err := tx.Stmt(i.stmt).Exec(
		strconv.FormatInt(int64(movieID), 10),
		strconv.FormatInt(int64(genreID), 10),
	)
	if err != nil {
		return fmt.Errorf("failed to insert media_genre: %v", err)
	}
	return nil
}
