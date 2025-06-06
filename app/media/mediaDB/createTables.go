package mediaDB

import (
	"database/sql"
	"fmt"
	"log/slog"
)

func CreateTables(db *sql.DB, logger *slog.Logger) error {
	logger.Info("creating media tables")
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
		
		CREATE INDEX IF NOT EXISTS idx_media_popularity ON media(popularity DESC);

		CREATE TABLE IF NOT EXISTS media_images (
			id TEXT PRIMARY KEY,
			media_id TEXT NOT NULL,
			image_type TEXT NOT NULL,
			resolution TEXT NOT NULL,
			url TEXT NOT NULL,
			FOREIGN KEY (media_id) REFERENCES media(id) ON DELETE CASCADE,
			UNIQUE(media_id, image_type, resolution)
		);

		CREATE INDEX IF NOT EXISTS idx_media_images_lookup 
		ON media_images(media_id, image_type, url);

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

	logger.Info("media tables created")

	tables := []string{"media", "media_images", "genres", "media_genres"}
	for _, table := range tables {
		var count int
		err := db.QueryRow(`SELECT count(*) FROM sqlite_master WHERE type='table' AND name=?`, table).Scan(&count)
		if err != nil {
			return fmt.Errorf("failed to check if table %s exists: %v", table, err)
		}
		if count == 0 {
			return fmt.Errorf("required table %s does not exist", table)
		}
	}

	return err
}
