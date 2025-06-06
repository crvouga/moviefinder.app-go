package tailwindcss

import (
	"io"
	"log"
	"net/http"
	"os"
	"os/exec"
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

	os.WriteFile("tailwindcss-linux-x64", body, 0755)

	os.Chmod("tailwindcss-linux-x64", 0755)

	log.Println("Tailwindcss downloaded")
}

func Linux64Invoke(inputPath string, outputPath string) {
	log.Println("Invoking tailwindcss-linux-x64")
	err := exec.Command("./tailwindcss-linux-x64", "-i", inputPath, "-o", outputPath, "--minify").Run()

	if err != nil {
		log.Fatal(err)
	} else {
		log.Println("Tailwindcss-linux-x64 invoked")
	}
}

func Linux64Remove() {
	log.Println("Removing tailwindcss-linux-x64")
	os.Remove("tailwindcss-linux-x64")
	log.Println("Tailwindcss-linux-x64 removed")
}

func Linux64Build(inputPath string, outputPath string) {
	Linux64Download()
	Linux64Invoke(inputPath, outputPath)
	Linux64Remove()
}

func IsLinux64() bool {
	return runtime.GOOS == "linux" && runtime.GOARCH == "amd64"
}
