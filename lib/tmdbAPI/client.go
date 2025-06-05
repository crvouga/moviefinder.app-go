// Package tmdbAPI provides access to The Movie Database (TMDB) API
package tmdbAPI

import (
	"encoding/json"
	"fmt"
	"io"
	"movieFinder/lib/dotEnv"
	"net/http"
	"net/url"
	"os"
)

// Client represents the TMDB API client configuration
type Client struct {
	ReadAccessToken string
	BaseURL         string
}

func New(readAccessToken string) *Client {
	return &Client{
		ReadAccessToken: readAccessToken,
		BaseURL:         BASE_URL,
	}
}

func NewFromEnv() *Client {
	err := dotEnv.Load()
	if err != nil {
		panic(err)
	}
	readAccessToken := os.Getenv("TMDB_API_READ_ACCESS_TOKEN")
	if readAccessToken == "" {
		panic("TMDB_API_READ_ACCESS_TOKEN is not set")
	}
	return New(readAccessToken)
}

func (t *Client) httpGet(path string, params interface{}, response interface{}) error {
	// Create URL values
	v := url.Values{}

	// Add params if provided
	if params != nil {
		// Use type switch to handle different param types
		switch p := params.(type) {
		case url.Values:
			for key, values := range p {
				for _, value := range values {
					v.Add(key, value)
				}
			}
		}
	}

	// Construct full URL
	fullURL := fmt.Sprintf("%s%s?%s", t.BaseURL, path, v.Encode())

	// Create request
	req, err := http.NewRequest("GET", fullURL, nil)
	if err != nil {
		return fmt.Errorf("error creating request: %w", err)
	}

	// Add authorization header
	req.Header.Set("Authorization", fmt.Sprintf("Bearer %s", t.ReadAccessToken))

	// Make request
	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		return fmt.Errorf("error making request: %w", err)
	}
	defer resp.Body.Close()

	// Read response body
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return fmt.Errorf("error reading response body: %w", err)
	}

	// Check status code
	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("API request failed with status %d: %s", resp.StatusCode, string(body))
	}

	// Parse JSON response
	err = json.Unmarshal(body, response)
	if err != nil {
		return fmt.Errorf("error parsing JSON response: %w", err)
	}

	return nil
}
