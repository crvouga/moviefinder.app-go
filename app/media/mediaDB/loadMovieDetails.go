package mediaDB

import "log"

func LoadMovieDetails(movieID int) chan struct{} {

	done := make(chan struct{})

	log.Println("Loading movie details", movieID)

	return done
}
