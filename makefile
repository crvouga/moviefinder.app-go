
run:
	go run main.go

build:
	make tw-build & go build -o main main.go

dev:
	air

test:
	clear && go test ./... -v

build:
	go build -o main main.go

clean:
	rm -f main
	rm -rf tmp

.PHONY: run dev test build clean

dbmate-download:
	curl -fsSL -o dbmate https://github.com/amacneil/dbmate/releases/latest/download/dbmate-macos-amd64
	chmod +x dbmate
	./dbmate --help

tw:
	make tw-watch

tw-download:
	curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-macos-arm64
	chmod +x tailwindcss-macos-arm64
	mv tailwindcss-macos-arm64 tailwindcss
	./tailwindcss --help

tw-watch:
	./tailwindcss -i ./public/input.css -o ./public/output.css --watch

tw-build:
	./tailwindcss -i ./public/input.css -o ./public/output.css --minify

preview:
	make build & make run