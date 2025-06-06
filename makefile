
run:
	go run main.go

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

tw:
	make tw-watch

tw-download:
	curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-macos-arm64
	chmod +x tailwindcss-macos-arm64
	mv tailwindcss-macos-arm64 tailwindcss

tw-watch:
	./tailwindcss -i ./public/input.css -o ./public/output.css --watch

tw-build:
	./tailwindcss -i ./public/input.css -o ./public/output.css --minify

preview:
	docker build -t moviefinder-app .
	docker run -p 8080:8080 moviefinder-app

preview-clean:
	docker rm -f moviefinder-app || true
	docker rmi moviefinder-app || true
	docker build -t moviefinder-app .
	docker run -p 8080:8080 moviefinder-app