package tailwindcss

import (
	"io"
	"log"
	"net/http"
	"os"
	"runtime"
)

func Linux64Download() {
	log.Println("Downloading tailwindcss-linux-x64")
	url := "https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-x64"

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

func IsLinux64() bool {
	return runtime.GOOS == "linux" && runtime.GOARCH == "amd64"
}
