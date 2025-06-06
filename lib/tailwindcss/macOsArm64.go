package tailwindcss

import (
	"io"
	"log"
	"net/http"
	"os"
	"os/exec"
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

	os.WriteFile("tailwindcss-macos-arm64", body, 0755)

	os.Chmod("tailwindcss-macos-arm64", 0755)

	log.Println("Tailwindcss downloaded")
}

func MacOSArm64Invoke(inputPath string, outputPath string) {
	log.Println("Invoking tailwindcss-macos-arm64")
	err := exec.Command("./tailwindcss-macos-arm64", "-i", inputPath, "-o", outputPath, "--minify").Run()

	if err != nil {
		log.Fatal(err)
	} else {
		log.Println("Tailwindcss-macos-arm64 invoked")
	}
}

func MacOSArm64Remove() {
	log.Println("Removing tailwindcss-macos-arm64")
	os.Remove("tailwindcss-macos-arm64")
	log.Println("Tailwindcss-macos-arm64 removed")
}

func MacOSArm64Build(inputPath string, outputPath string) {
	MacOSArm64Download()
	MacOSArm64Invoke(inputPath, outputPath)
	MacOSArm64Remove()
}

func IsMacOSArm64() bool {
	return runtime.GOOS == "darwin" && runtime.GOARCH == "arm64"
}
