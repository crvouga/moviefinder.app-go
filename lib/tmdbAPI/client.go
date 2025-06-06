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
	v := buildURLValues(params)
	fullURL := fmt.Sprintf("%s%s?%s", t.BaseURL, path, v.Encode())
	t.logger.Debug("fullURL", "fullURL", fullURL)

	req, err := createRequest(fullURL, t.ReadAccessToken)
	if err != nil {
		return err
	}

	body, statusCode, err := makeRequest(req)
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

func buildURLValues(params any) url.Values {
	v := url.Values{}
	if params == nil {
		return v
	}

	switch p := params.(type) {
	case url.Values:
		return copyURLValues(p)
	default:
		return buildURLValuesFromStruct(p)
	}
}

func copyURLValues(values url.Values) url.Values {
	v := url.Values{}
	for key, vals := range values {
		for _, value := range vals {
			v.Add(key, value)
		}
	}
	return v
}

func buildURLValuesFromStruct(params any) url.Values {
	v := url.Values{}
	val := reflect.ValueOf(params)
	typ := val.Type()

	for i := 0; i < val.NumField(); i++ {
		field := typ.Field(i)
		tag := getURLTag(field)
		if tag == "" {
			continue
		}

		value := val.Field(i).Interface()
		if isEmptyValue(value) {
			continue
		}
		v.Add(tag, fmt.Sprintf("%v", value))
	}
	return v
}

func getURLTag(field reflect.StructField) string {
	tag := field.Tag.Get("url")
	if tag == "" || tag == "-" {
		return ""
	}
	tagParts := strings.Split(tag, ",")
	return tagParts[0]
}

func isEmptyValue(value interface{}) bool {
	return value == nil || value == "" || value == 0 || value == false
}

func createRequest(url string, readAccessToken string) (*http.Request, error) {
	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		return nil, fmt.Errorf("error creating request: %w", err)
	}
	req.Header.Set("Authorization", fmt.Sprintf("Bearer %s", readAccessToken))
	return req, nil
}

func makeRequest(req *http.Request) ([]byte, int, error) {
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
