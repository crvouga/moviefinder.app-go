package mediaDB

import (
	"database/sql"
	"fmt"
	"log"
	"movieFinder/lib/tmdbAPI"
	"strconv"
)

func processMovie(db *sql.DB, movie tmdbAPI.DiscoverMovieResponseResult, configuration tmdbAPI.ConfigurationResponse, posterSizes []string, backdropSizes []string) error {
	log.Printf("Processing movie: %s (ID: %d)", movie.Title, movie.ID)
	log.Printf("Movie details - Title: %s, Popularity: %f, Release Date: %s", movie.Title, movie.Popularity, movie.ReleaseDate)

	posterURLs := tmdbAPI.ToPosterURLs(movie.PosterPath, configuration, posterSizes)
	backdropURLs := tmdbAPI.ToBackdropURLs(movie.BackdropPath, configuration, backdropSizes)

	log.Printf("Generated %d poster URLs and %d backdrop URLs", len(posterURLs), len(backdropURLs))

	// Begin transaction
	tx, err := db.Begin()
	if err != nil {
		return fmt.Errorf("failed to begin transaction: %v", err)
	}
	defer tx.Rollback()

	log.Printf("Starting database transaction for movie %d", movie.ID)

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

	log.Printf("Inserted base movie data for ID %d", movie.ID)

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
		log.Printf("Inserted poster image %d/%d for movie %d", i+1, len(posterURLs), movie.ID)
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
		log.Printf("Inserted backdrop image %d/%d for movie %d", i+1, len(backdropURLs), movie.ID)
	}

	log.Printf("Processing %d genres for movie %d", len(movie.GenreIds), movie.ID)

	// Insert genres and media_genres relationships
	for i, genreID := range movie.GenreIds {
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
		log.Printf("Processed genre %d/%d (ID: %d) for movie %d", i+1, len(movie.GenreIds), genreID, movie.ID)
	}

	// Commit transaction
	if err = tx.Commit(); err != nil {
		return fmt.Errorf("failed to commit transaction: %v", err)
	}

	log.Printf("Successfully completed database transaction for movie %d", movie.ID)
	return nil
}

func processMoviePage(db *sql.DB, client *tmdbAPI.Client, page int, configuration tmdbAPI.ConfigurationResponse) (bool, error) {
	log.Printf("Fetching page %d of movies from TMDB API...", page)

	response, err := client.DiscoverMovie(tmdbAPI.DiscoverMovieParams{
		Page: page,
	})
	if err != nil {
		log.Printf("Failed to get page %d: %v", page, err)
		return false, err
	}

	log.Printf("Retrieved %d movies from page %d (Total pages: %d)", len(response.Results), page, response.TotalPages)
	posterSizes := configuration.Images.PosterSizes
	backdropSizes := configuration.Images.BackdropSizes

	for i, movie := range response.Results {
		log.Printf("Processing movie %d/%d on page %d", i+1, len(response.Results), page)
		if err := processMovie(db, movie, configuration, posterSizes, backdropSizes); err != nil {
			log.Printf("Error processing movie %d: %v", movie.ID, err)
		}
	}

	log.Printf("Successfully processed page %d (%d movies)", page, len(response.Results))
	return page >= response.TotalPages, nil
}

const HARD_MAX_PAGES = 500

func LoaderTmdbAPIDiscoverMovie(db *sql.DB, client *tmdbAPI.Client, maxPages int, done chan struct{}) error {

	go func() {
		log.Println("Starting TMDB Discover Movie loader worker...")
		log.Printf("Will process up to %d pages", maxPages)

		configuration, err := client.Configuration()
		if err != nil {
			log.Printf("Failed to get configuration: %v", err)
			close(done)
			return
		}
		log.Printf("Got TMDB configuration successfully. Base URL: %s", configuration.Images.SecureBaseURL)
		log.Printf("Available poster sizes: %v", configuration.Images.PosterSizes)
		log.Printf("Available backdrop sizes: %v", configuration.Images.BackdropSizes)

		page := 1

		for page <= maxPages && page <= HARD_MAX_PAGES {
			isLastPage, err := processMoviePage(db, client, page, configuration)
			if err != nil {
				log.Printf("Stopping loader due to error on page %d: %v", page, err)
				break
			}
			if isLastPage {
				log.Println("Reached last page, media loader complete")
				break
			}
			page++
		}

		log.Printf("TMDB Discover Movie loader completed after processing %d pages", page)
		close(done)
	}()

	return nil
}
