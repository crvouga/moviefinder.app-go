package tailwindcss

import (
	"io"
	"log"
	"net/http"
	"os"
	"runtime"
)

func MacOSArm64Download() {
	log.Println("Downloading tailwindcss-macos-arm64")
	url := "https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-macos-arm64"

	log.Println("URL: ", url)

	response, err := http.Get(url)

	if err != nil {
		log.Fatal(err)
	}
	defer response.Body.Close()

	body, err := io.ReadAll(response.Body)
	if err != nil {
		log.Fatal(err)
	}

	os.WriteFile("tailwindcss", body, 0755)

	os.Chmod("tailwindcss", 0755)

	log.Println("Tailwindcss downloaded")
}

func IsMacOSArm64() bool {
	return runtime.GOOS == "darwin" && runtime.GOARCH == "arm64"
}
