package mediaDB

import (
	"database/sql"
	"movieFinder/app/media"
)

type QueryPopularMedia struct {
	stmt *sql.Stmt
}

func NewQueryPopularMedia(db *sql.DB) (*QueryPopularMedia, error) {
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
		ORDER BY popularity DESC
		LIMIT ? OFFSET ?
	`)

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
