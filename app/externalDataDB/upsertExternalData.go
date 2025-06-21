package externalDataDB

import (
	"database/sql"
	_ "embed"
	"encoding/json"
)

//go:embed upsertExternalData.psql
var upsertExternalDataSQL string

type UpsertExternalData struct {
	stmt *sql.Stmt
}

func NewUpsertExternalData(db *sql.DB) (*UpsertExternalData, error) {
	stmt, err := db.Prepare(upsertExternalDataSQL)
	if err != nil {
		return nil, err
	}

	return &UpsertExternalData{
		stmt: stmt,
	}, nil
}

func (u *UpsertExternalData) Execute(tx *sql.Tx, dataType, id string, data interface{}) error {
	jsonData, err := json.Marshal(data)
	if err != nil {
		return err
	}

	_, err = tx.Stmt(u.stmt).Exec(id, dataType, jsonData)

	return err
}

func (u *UpsertExternalData) Close() error {
	if u.stmt != nil {
		return u.stmt.Close()
	}
	return nil
}
