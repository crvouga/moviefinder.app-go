// Package tmdbAPI provides access to The Movie Database (TMDB) API
package tmdbAPI

import (
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"log"
	"log/slog"
	"movieFinder/lib/dotEnv"
	"net/http"
	"net/url"
	"os"
	"reflect"
	"strings"
)

// Client represents the TMDB API client configuration
type Client struct {
	ReadAccessToken string
	BaseURL         string
	logger          *slog.Logger
}

func New(readAccessToken string, logger *slog.Logger) *Client {
	return &Client{
		ReadAccessToken: readAccessToken,
		BaseURL:         BASE_URL,
		logger:          logger,
	}
}

func NewFromEnv(logger *slog.Logger) (*Client, error) {
	err := dotEnv.Load()

	if err != nil {
		log.Printf("Error loading .env file: %v", err)
	}

	readAccessToken := os.Getenv("TMDB_API_READ_ACCESS_TOKEN")

	if readAccessToken == "" {
		return nil, errors.New("TMDB_API_READ_ACCESS_TOKEN is not set")
	}

	return New(readAccessToken, logger), nil
}

func (t *Client) httpGet(path string, params any, response any) error {
	v := t.buildURLValues(params)
	fullURL := fmt.Sprintf("%s%s?%s", t.BaseURL, path, v.Encode())
	t.logger.Info("fullURL", "fullURL", fullURL)

	req, err := t.createRequest(fullURL)
	if err != nil {
		return err
	}

	body, statusCode, err := t.makeRequest(req)
	if err != nil {
		return err
	}

	if statusCode != http.StatusOK {
		return fmt.Errorf("API request failed with status %d: %s", statusCode, string(body))
	}

	if err := json.Unmarshal(body, response); err != nil {
		return fmt.Errorf("error parsing JSON response: %w", err)
	}

	return nil
}

func (t *Client) buildURLValues(params any) url.Values {
	v := url.Values{}
	if params == nil {
		return v
	}

	switch p := params.(type) {
	case url.Values:
		for key, values := range p {
			for _, value := range values {
				v.Add(key, value)
			}
		}
	default:
		val := reflect.ValueOf(p)
		typ := val.Type()
		for i := 0; i < val.NumField(); i++ {
			field := typ.Field(i)
			tag := field.Tag.Get("url")
			if tag == "" || tag == "-" {
				continue
			}
			tagParts := strings.Split(tag, ",")
			tag = tagParts[0]

			value := val.Field(i).Interface()
			if value == nil || value == "" || value == 0 || value == false {
				continue
			}
			v.Add(tag, fmt.Sprintf("%v", value))
		}
	}
	return v
}

func (t *Client) createRequest(url string) (*http.Request, error) {
	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		return nil, fmt.Errorf("error creating request: %w", err)
	}
	req.Header.Set("Authorization", fmt.Sprintf("Bearer %s", t.ReadAccessToken))
	return req, nil
}

func (t *Client) makeRequest(req *http.Request) ([]byte, int, error) {
	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		return nil, 0, fmt.Errorf("error making request: %w", err)
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, 0, fmt.Errorf("error reading response body: %w", err)
	}

	return body, resp.StatusCode, nil
}
