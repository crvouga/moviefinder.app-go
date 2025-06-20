// https://developer.themoviedb.org/reference/configuration-details
package tmdbAPI

type ConfigurationResponse struct {
	Images struct {
		BaseURL       string   `json:"base_url"`
		SecureBaseURL string   `json:"secure_base_url"`
		BackdropSizes []string `json:"backdrop_sizes"`
		LogoSizes     []string `json:"logo_sizes"`
		PosterSizes   []string `json:"poster_sizes"`
		ProfileSizes  []string `json:"profile_sizes"`
	} `json:"images"`
}

func (t *Client) Configuration() (ConfigurationResponse, error) {
	var response ConfigurationResponse
	t.logger.Debug("getting TMDB configuration")
	err := t.httpGet("/configuration", nil, &response)
	t.logger.Debug("got TMDB configuration", "response", response)
	if err != nil {
		t.logger.Error("failed to get TMDB configuration", "error", err)
		return ConfigurationResponse{}, err
	}
	return response, nil
}

func ToPosterURLs(posterPath string, configuration ConfigurationResponse, posterSizes []string) []string {
	posterURLs := make([]string, 0, len(posterSizes))
	if posterPath != "" {
		for _, size := range posterSizes {
			posterURLs = append(posterURLs, configuration.Images.SecureBaseURL+size+posterPath)
		}
	}
	return posterURLs
}

func ToBackdropURLs(backdropPath string, configuration ConfigurationResponse, backdropSizes []string) []string {
	backdropURLs := make([]string, 0, len(backdropSizes))
	if backdropPath != "" {
		for _, size := range backdropSizes {
			backdropURLs = append(backdropURLs, configuration.Images.SecureBaseURL+size+backdropPath)
		}
	}
	return backdropURLs
}
