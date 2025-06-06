package tailwindcss

import (
	"log"
	"os"
	"os/exec"
)

func Download() {
	log.Println("Building tailwindcss")

	isLinux64 := IsLinux64()
	isMacOSArm64 := IsMacOSArm64()

	log.Println("isLinux64: ", isLinux64)
	log.Println("isMacOSArm64: ", isMacOSArm64)

	if isLinux64 {
		Linux64Download()
	} else if isMacOSArm64 {
		MacOSArm64Download()
	} else {
		log.Println("Not building tailwindcss unsupported platform")
	}
}

func DownloadCached() {
	log.Println("Checking for cached tailwindcss")

	if _, err := os.Stat("tailwindcss"); os.IsNotExist(err) {
		log.Println("No cached tailwindcss found, downloading...")
		Download()
	} else {
		log.Println("Using cached tailwindcss")
	}
}

func Invoke(inputPath string, outputPath string) {
	log.Println("Invoking tailwindcss")
	err := exec.Command("./tailwindcss", "-i", inputPath, "-o", outputPath, "--minify").Run()

	if err != nil {
		log.Fatal(err)
	} else {
		log.Println("Tailwindcss invoked")
	}
}

func Build(inputPath string, outputPath string) {
	DownloadCached()
	Invoke(inputPath, outputPath)
}
