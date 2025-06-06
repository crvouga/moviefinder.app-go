package mediaDB

import (
	"database/sql"
	_ "embed"
	"movieFinder/app/media"
)

//go:embed queryPopularMedia.sql
var queryPopularMediaSQL string

type QueryPopularMedia struct {
	stmt *sql.Stmt
}

func NewQueryPopularMedia(db *sql.DB) (*QueryPopularMedia, error) {
	stmt, err := db.Prepare(queryPopularMediaSQL)

	if err != nil {
		return nil, err
	}

	return &QueryPopularMedia{stmt: stmt}, nil
}

func (q *QueryPopularMedia) Close() error {
	return q.stmt.Close()
}

func (q *QueryPopularMedia) Query(limit int, offset int) ([]media.Media, error) {
	rows, err := q.stmt.Query(limit, offset)
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

	return ret, nil
}
