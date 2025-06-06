package tailwindcss

import (
	"log"
)

func Build(inputPath string, outputPath string) {
	log.Println("Building tailwindcss")

	isLinux64 := IsLinux64()
	isMacOSArm64 := IsMacOSArm64()

	log.Println("isLinux64: ", isLinux64)
	log.Println("isMacOSArm64: ", isMacOSArm64)

	if isLinux64 {
		Linux64Build(inputPath, outputPath)
	} else if isMacOSArm64 {
		MacOSArm64Build(inputPath, outputPath)
	} else {
		log.Println("Not building tailwindcss unsupported platform")
	}
}
