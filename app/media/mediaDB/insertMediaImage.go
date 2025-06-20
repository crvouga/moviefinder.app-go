package mediaDB

import (
	"database/sql"
	_ "embed"
	"fmt"
)

//go:embed insertMediaImage.sql
var insertMediaImageSQL string

type InsertMediaImage struct {
	stmt *sql.Stmt
}

func NewInsertMediaImage(db *sql.DB) (*InsertMediaImage, error) {
	stmt, err := db.Prepare(insertMediaImageSQL)
	if err != nil {
		return nil, err
	}
	return &InsertMediaImage{stmt: stmt}, nil
}

func (i *InsertMediaImage) Close() error {
	return i.stmt.Close()
}

func (i *InsertMediaImage) Execute(tx *sql.Tx, id, mediaID, imageType, resolution, url string) error {
	_, err := tx.Stmt(i.stmt).Exec(id, mediaID, imageType, resolution, url)
	if err != nil {
		return fmt.Errorf("failed to insert media image: %v", err)
	}
	return nil
}
