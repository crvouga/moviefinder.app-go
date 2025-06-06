package mediaDB

import (
	"database/sql"
	_ "embed"
	"movieFinder/app/media"
)

//go:embed queryMediaByID.sql
var queryMediaByIDSQL string

type QueryMediaByID struct {
	stmt *sql.Stmt
}

func NewQueryMediaByID(db *sql.DB) (*QueryMediaByID, error) {
	stmt, err := db.Prepare(queryMediaByIDSQL)

	if err != nil {
		return nil, err
	}

	return &QueryMediaByID{stmt: stmt}, nil
}

func (q *QueryMediaByID) Close() error {
	return q.stmt.Close()
}

func (q *QueryMediaByID) Query(mediaID string) (*media.Media, error) {
	rows, err := q.stmt.Query(mediaID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var ret []media.Media

	for rows.Next() {
		var m media.Media
		err := rows.Scan(&m.ID, &m.Title, &m.Description, &m.Popularity, &m.PosterURL, &m.BackdropURL)
		if err != nil {
			return nil, err
		}
		ret = append(ret, m)
	}

	if len(ret) == 0 {
		return nil, nil
	}
	return &ret[0], nil
}
