package mediaDB

import (
	"database/sql"
	_ "embed"
	"fmt"
	"strconv"
)

//go:embed insertGenre.sql
var insertGenreSQL string

type InsertGenre struct {
	stmt *sql.Stmt
}

func NewInsertGenre(db *sql.DB) (*InsertGenre, error) {
	stmt, err := db.Prepare(insertGenreSQL)
	if err != nil {
		return nil, err
	}
	return &InsertGenre{stmt: stmt}, nil
}

func (i *InsertGenre) Close() error {
	return i.stmt.Close()
}

func (i *InsertGenre) Execute(tx *sql.Tx, genreID int) error {
	_, err := tx.Stmt(i.stmt).Exec(
		strconv.FormatInt(int64(genreID), 10),
		"", // Name will be updated later when we have genre details
	)
	if err != nil {
		return fmt.Errorf("failed to insert genre: %v", err)
	}
	return nil
}
