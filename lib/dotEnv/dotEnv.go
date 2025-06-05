package dotEnv

import (
	"bufio"
	"fmt"
	"os"
	"path/filepath"
	"strings"
)

func Load() error {
	// Get executable directory
	dir, err := os.Getwd()
	if err != nil {
		return fmt.Errorf("error getting working directory: %w", err)
	}

	// Find root directory (where .env file is)
	rootDir := dir
	for {
		if _, err := os.Stat(filepath.Join(rootDir, ".env")); err == nil {
			break
		}
		parentDir := filepath.Dir(rootDir)
		if parentDir == rootDir {
			return fmt.Errorf(".env file not found in any parent directory")
		}
		rootDir = parentDir
	}

	// Open .env file from root directory
	file, err := os.Open(filepath.Join(rootDir, ".env"))
	if err != nil {
		return fmt.Errorf("error opening .env file: %w", err)
	}
	defer file.Close()

	// Create scanner to read file line by line
	scanner := bufio.NewScanner(file)

	// Read each line
	for scanner.Scan() {
		line := scanner.Text()

		// Skip empty lines and comments
		if len(line) == 0 || strings.HasPrefix(line, "#") {
			continue
		}

		// Split on first = sign
		parts := strings.SplitN(line, "=", 2)
		if len(parts) != 2 {
			continue
		}

		// Trim whitespace from key and value
		key := strings.TrimSpace(parts[0])
		value := strings.TrimSpace(parts[1])

		// Remove quotes if present
		value = strings.Trim(value, `"'`)

		// Set environment variable
		err := os.Setenv(key, value)
		if err != nil {
			return fmt.Errorf("error setting environment variable %s: %w", key, err)
		}
	}

	if err := scanner.Err(); err != nil {
		return fmt.Errorf("error reading .env file: %w", err)
	}

	return nil
}
