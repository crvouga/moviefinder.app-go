package mediaDB

import (
	"database/sql"
	"log"
	"movieFinder/lib/tmdbAPI"
)

func Loader(db *sql.DB, client *tmdbAPI.Client, maxPages int, done chan struct{}) error {
	log.Printf("Starting media loader with max pages: %d", maxPages)
	err := LoaderTmdbAPIDiscoverMovie(db, client, maxPages, done)
	if err != nil {
		log.Printf("Error in media loader: %v", err)
		return err
	}
	log.Println("Media loader completed successfully")
	return nil
}
