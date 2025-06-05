// https://developer.themoviedb.org/reference/discover-movie
package tmdbAPI

type DiscoverMovieParams struct {
	Page                       int     `url:"page,omitempty"`
	Language                   string  `url:"language,omitempty"`
	SortBy                     string  `url:"sort_by,omitempty"`
	Certification              string  `url:"certification,omitempty"`
	CertificationGte           string  `url:"certification.gte,omitempty"`
	CertificationLte           string  `url:"certification.lte,omitempty"`
	CertificationCountry       string  `url:"certification_country,omitempty"`
	IncludeAdult               bool    `url:"include_adult,omitempty"`
	IncludeVideo               bool    `url:"include_video,omitempty"`
	PrimaryReleaseYear         int     `url:"primary_release_year,omitempty"`
	PrimaryReleaseDateGte      string  `url:"primary_release_date.gte,omitempty"`
	PrimaryReleaseDateLte      string  `url:"primary_release_date.lte,omitempty"`
	Region                     string  `url:"region,omitempty"`
	ReleaseDateGte             string  `url:"release_date.gte,omitempty"`
	ReleaseDateLte             string  `url:"release_date.lte,omitempty"`
	VoteAverageGte             float64 `url:"vote_average.gte,omitempty"`
	VoteAverageLte             float64 `url:"vote_average.lte,omitempty"`
	VoteCountGte               float64 `url:"vote_count.gte,omitempty"`
	VoteCountLte               float64 `url:"vote_count.lte,omitempty"`
	WatchRegion                string  `url:"watch_region,omitempty"`
	WithCast                   string  `url:"with_cast,omitempty"`
	WithCompanies              string  `url:"with_companies,omitempty"`
	WithCrew                   string  `url:"with_crew,omitempty"`
	WithGenres                 string  `url:"with_genres,omitempty"`
	WithKeywords               string  `url:"with_keywords,omitempty"`
	WithOriginCountry          string  `url:"with_origin_country,omitempty"`
	WithOriginalLanguage       string  `url:"with_original_language,omitempty"`
	WithPeople                 string  `url:"with_people,omitempty"`
	WithReleaseType            int     `url:"with_release_type,omitempty"`
	WithRuntimeGte             int     `url:"with_runtime.gte,omitempty"`
	WithRuntimeLte             int     `url:"with_runtime.lte,omitempty"`
	WithWatchMonetizationTypes string  `url:"with_watch_monetization_types,omitempty"`
	WithWatchProviders         string  `url:"with_watch_providers,omitempty"`
	WithoutCompanies           string  `url:"without_companies,omitempty"`
	WithoutGenres              string  `url:"without_genres,omitempty"`
	WithoutKeywords            string  `url:"without_keywords,omitempty"`
	WithoutWatchProviders      string  `url:"without_watch_providers,omitempty"`
	Year                       int     `url:"year,omitempty"`
}

type DiscoverMovieResponse struct {
	Page         int                           `json:"page"`
	TotalPages   int                           `json:"total_pages"`
	TotalResults int                           `json:"total_results"`
	Results      []DiscoverMovieResponseResult `json:"results"`
}

type DiscoverMovieResponseResult struct {
	Adult            bool    `json:"adult"`
	BackdropPath     string  `json:"backdrop_path"`
	GenreIds         []int   `json:"genre_ids"`
	ID               int     `json:"id"`
	OriginalLanguage string  `json:"original_language"`
	OriginalTitle    string  `json:"original_title"`
	Overview         string  `json:"overview"`
	Popularity       float64 `json:"popularity"`
	PosterPath       string  `json:"poster_path"`
	ReleaseDate      string  `json:"release_date"`
	Title            string  `json:"title"`
	Video            bool    `json:"video"`
	VoteAverage      float64 `json:"vote_average"`
	VoteCount        int     `json:"vote_count"`
}

func (t *TmdbAPI) DiscoverMovie(params DiscoverMovieParams) (DiscoverMovieResponse, error) {
	var response DiscoverMovieResponse
	err := t.httpGet("/discover/movie", params, &response)
	if err != nil {
		return DiscoverMovieResponse{}, err
	}
	return response, nil
}
