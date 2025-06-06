package mediaDB

import (
	"database/sql"
	"movieFinder/app/media"
)

type QueryMediaByID struct {
	stmt *sql.Stmt
}

func NewQueryMediaByID(db *sql.DB) (*QueryMediaByID, error) {
	stmt, err := db.Prepare(`
		SELECT
			id,
			title,
			description,
			popularity,
			COALESCE(
				(SELECT url FROM media_images WHERE media_id = media.id AND image_type = 'poster' LIMIT 1),
				''
			) AS poster_url,
			COALESCE(
				(SELECT url FROM media_images WHERE media_id = media.id AND image_type = 'backdrop' LIMIT 1),
				''
			) AS backdrop_url
		FROM media	
		WHERE id = ?
	`)

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
