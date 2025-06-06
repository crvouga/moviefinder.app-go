package mediaDB

import (
	"database/sql"
)

func CreateTables(db *sql.DB) error {

	_, err := db.Exec(`
		CREATE TABLE IF NOT EXISTS media (
			id TEXT PRIMARY KEY,
			title TEXT NOT NULL,
			description TEXT NOT NULL,
			popularity REAL NOT NULL,
			release_date TEXT NOT NULL,
			vote_average REAL NOT NULL,
			vote_count INTEGER NOT NULL,
			runtime INTEGER NOT NULL
		);

		CREATE TABLE IF NOT EXISTS media_images (
			id TEXT PRIMARY KEY,
			media_id TEXT NOT NULL,
			image_type TEXT NOT NULL,
			resolution TEXT NOT NULL,
			url TEXT NOT NULL,
			FOREIGN KEY (media_id) REFERENCES media(id) ON DELETE CASCADE,
			UNIQUE(media_id, image_type, resolution)
		);

		CREATE TABLE IF NOT EXISTS genres (
			id TEXT PRIMARY KEY,
			name TEXT NOT NULL
		);

		CREATE TABLE IF NOT EXISTS media_genres (
			media_id TEXT NOT NULL,
			genre_id TEXT NOT NULL,
			FOREIGN KEY (media_id) REFERENCES media(id) ON DELETE CASCADE,
			FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE,
			PRIMARY KEY (media_id, genre_id)
		)
	`)

	return err
}
