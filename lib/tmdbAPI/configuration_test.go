package tmdbAPI

import (
	"testing"
)

func Test_Configuration(t *testing.T) {
	f := NewFixture()

	response, err := f.tmdbAPI.Configuration()
	if err != nil {
		t.Fatalf("Configuration returned error: %v", err)
	}

	// Check that image configuration is valid
	if response.Images.BaseURL == "" {
		t.Error("Expected base URL to be non-empty")
	}

	if response.Images.SecureBaseURL == "" {
		t.Error("Expected secure base URL to be non-empty")
	}

	// Check that size arrays are populated
	if len(response.Images.BackdropSizes) == 0 {
		t.Error("Expected backdrop sizes but got none")
	}

	if len(response.Images.LogoSizes) == 0 {
		t.Error("Expected logo sizes but got none")
	}

	if len(response.Images.PosterSizes) == 0 {
		t.Error("Expected poster sizes but got none")
	}

	if len(response.Images.ProfileSizes) == 0 {
		t.Error("Expected profile sizes but got none")
	}
}
