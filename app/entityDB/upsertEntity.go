package entityDB

import (
	"database/sql"
	_ "embed"
	"encoding/json"
)

//go:embed upsertEntity.sql
var upsertEntitySQL string

type UpsertEntity struct {
	stmt *sql.Stmt
}

func NewUpsertEntity(db *sql.DB) (*UpsertEntity, error) {
	stmt, err := db.Prepare(upsertEntitySQL)
	if err != nil {
		return nil, err
	}

	return &UpsertEntity{
		stmt: stmt,
	}, nil
}

func (u *UpsertEntity) Execute(tx *sql.Tx, dataType, id string, data interface{}) error {
	jsonData, err := json.Marshal(data)
	if err != nil {
		return err
	}

	_, err = tx.Stmt(u.stmt).Exec(id, dataType, jsonData)

	return err
}

func (u *UpsertEntity) Close() error {
	if u.stmt != nil {
		return u.stmt.Close()
	}
	return nil
}
