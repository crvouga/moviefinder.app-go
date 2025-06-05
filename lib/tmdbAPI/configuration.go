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

func (t *TmdbAPI) Configuration() (ConfigurationResponse, error) {
	var response ConfigurationResponse
	err := t.httpGet("/configuration", nil, &response)
	if err != nil {
		return ConfigurationResponse{}, err
	}
	return response, nil
}
