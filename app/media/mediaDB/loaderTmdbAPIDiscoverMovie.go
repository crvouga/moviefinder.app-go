package mediaDB

import (
	"database/sql"
	"fmt"
	"log"
	"movieFinder/lib/tmdbAPI"
	"strconv"
	"time"
)

func processMovie(db *sql.DB, movie tmdbAPI.DiscoverMovieResponseResult, configuration tmdbAPI.ConfigurationResponse, posterSizes []string, backdropSizes []string) error {
	log.Printf("Processing movie: %s (ID: %d)", movie.Title, movie.ID)

	posterURLs := tmdbAPI.ToPosterURLs(movie.PosterPath, configuration, posterSizes)
	backdropURLs := tmdbAPI.ToBackdropURLs(movie.BackdropPath, configuration, backdropSizes)

	// Begin transaction
	tx, err := db.Begin()
	if err != nil {
		return fmt.Errorf("failed to begin transaction: %v", err)
	}
	defer tx.Rollback()

	// Insert movie
	_, err = tx.Exec(`
		INSERT OR REPLACE INTO media (
			id,
			title,
			description,
			popularity,
			release_date,
			vote_average,
			vote_count,
			runtime
		) VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
		strconv.FormatInt(int64(movie.ID), 10),
		movie.Title,
		movie.Overview,
		movie.Popularity,
		movie.ReleaseDate,
		movie.VoteAverage,
		movie.VoteCount,
		0, // Runtime not available in discover response
	)
	if err != nil {
		return fmt.Errorf("failed to insert movie: %v", err)
	}

	// Insert poster images
	for i, posterURL := range posterURLs {
		_, err = tx.Exec(`
			INSERT OR REPLACE INTO media_images (
				id,
				media_id,
				image_type,
				resolution,
				url
			) VALUES (?, ?, ?, ?, ?)`,
			fmt.Sprintf("%d_poster_%d", movie.ID, i),
			strconv.FormatInt(int64(movie.ID), 10),
			"poster",
			posterSizes[i],
			posterURL,
		)
		if err != nil {
			return fmt.Errorf("failed to insert poster image: %v", err)
		}
	}

	// Insert backdrop images
	for i, backdropURL := range backdropURLs {
		_, err = tx.Exec(`
			INSERT OR REPLACE INTO media_images (
				id,
				media_id,
				image_type,
				resolution,
				url
			) VALUES (?, ?, ?, ?, ?)`,
			fmt.Sprintf("%d_backdrop_%d", movie.ID, i),
			strconv.FormatInt(int64(movie.ID), 10),
			"backdrop",
			backdropSizes[i],
			backdropURL,
		)
		if err != nil {
			return fmt.Errorf("failed to insert backdrop image: %v", err)
		}
	}

	// Insert genres and media_genres relationships
	for _, genreID := range movie.GenreIds {
		// Insert genre if not exists
		_, err = tx.Exec(`
			INSERT OR IGNORE INTO genres (id, name) VALUES (?, ?)`,
			strconv.FormatInt(int64(genreID), 10),
			"", // Name will be updated later when we have genre details
		)
		if err != nil {
			return fmt.Errorf("failed to insert genre: %v", err)
		}

		// Create media-genre relationship
		_, err = tx.Exec(`
			INSERT OR IGNORE INTO media_genres (media_id, genre_id) VALUES (?, ?)`,
			strconv.FormatInt(int64(movie.ID), 10),
			strconv.FormatInt(int64(genreID), 10),
		)
		if err != nil {
			return fmt.Errorf("failed to insert media_genre: %v", err)
		}
	}

	// Commit transaction
	if err = tx.Commit(); err != nil {
		return fmt.Errorf("failed to commit transaction: %v", err)
	}

	log.Printf("Successfully inserted movie %d into database", movie.ID)
	return nil
}

func processMoviePage(db *sql.DB, client *tmdbAPI.Client, page int, configuration tmdbAPI.ConfigurationResponse) (bool, error) {
	log.Printf("Fetching page %d of movies...", page)
	time.Sleep(1 * time.Second) // Rate limiting

	response, err := client.DiscoverMovie(tmdbAPI.DiscoverMovieParams{
		Page: page,
	})
	if err != nil {
		log.Printf("Failed to get page %d: %v", page, err)
		return false, err
	}

	log.Printf("Retrieved %d movies from page %d", len(response.Results), page)
	posterSizes := configuration.Images.PosterSizes
	backdropSizes := configuration.Images.BackdropSizes

	for _, movie := range response.Results {
		if err := processMovie(db, movie, configuration, posterSizes, backdropSizes); err != nil {
			log.Printf("Error processing movie %d: %v", movie.ID, err)
		}
	}

	log.Printf("Successfully processed page %d (%d movies)", page, len(response.Results))
	return page >= response.TotalPages, nil
}

func LoaderTmdbAPIDiscoverMovie(db *sql.DB, client *tmdbAPI.Client, maxPages int, done chan struct{}) error {
	go func() {
		log.Println("Starting TMDB Discover Movie loader worker...")

		configuration, err := client.Configuration()
		if err != nil {
			log.Printf("Failed to get configuration: %v", err)
			close(done)
			return
		}
		log.Printf("Got TMDB configuration successfully. Base URL: %s", configuration.Images.SecureBaseURL)

		page := 1
		for page <= maxPages {
			isLastPage, err := processMoviePage(db, client, page, configuration)
			if err != nil {
				log.Printf("Stopping loader due to error on page %d", page)
				break
			}
			if isLastPage {
				log.Println("Reached last page, media loader complete")
				break
			}
			page++
		}
		close(done)
	}()

	return nil
}
