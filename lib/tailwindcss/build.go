package tailwindcss

import (
	"log"
	"os"
)

func Build(inputPath string, outputPath string) {
	log.Println("Building tailwindcss")

	isLinux64 := os.Getenv("GOOS") == "linux" && os.Getenv("GOARCH") == "amd64"

	log.Println("GOOS: ", os.Getenv("GOOS"))
	log.Println("GOARCH: ", os.Getenv("GOARCH"))

	log.Println("isLinux64: ", isLinux64)

	if isLinux64 {
		Linux64Build(inputPath, outputPath)
	} else {
		log.Println("Not building tailwindcss unsupported platform")
	}
}
