// https://developer.themoviedb.org/reference/genre-movie-list
package tmdbAPI

type GenresMovieResponse struct {
	Genres []GenreMovie `json:"genres"`
}

type GenreMovie struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

func (t *Client) GenresMovie() (GenresMovieResponse, error) {
	var response GenresMovieResponse
	err := t.httpGet("/genre/movie/list", nil, &response)
	if err != nil {
		return GenresMovieResponse{}, err
	}
	return response, nil
}
