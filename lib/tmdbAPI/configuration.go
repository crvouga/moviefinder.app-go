// https://developer.themoviedb.org/reference/configuration-details
package tmdbAPI

import "log"

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
	err := t.httpGet("/configuration", nil, &response)
	if err != nil {
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
		log.Printf("Generated %d poster URLs", len(posterURLs))
	} else {
		log.Print("No poster path provided")
	}
	return posterURLs
}

func ToBackdropURLs(backdropPath string, configuration ConfigurationResponse, backdropSizes []string) []string {
	backdropURLs := make([]string, 0, len(backdropSizes))
	if backdropPath != "" {
		for _, size := range backdropSizes {
			backdropURLs = append(backdropURLs, configuration.Images.SecureBaseURL+size+backdropPath)
		}
		log.Printf("Generated %d backdrop URLs", len(backdropURLs))
	} else {
		log.Print("No backdrop path provided")
	}
	return backdropURLs
}
