
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

preview:
	docker build -t moviefinder . && docker run -p 8080:8080 moviefinder

sqlite:
	sqlite3 db/db.sqlite3

dbmate-download:
	curl -fsSL -o dbmate https://github.com/amacneil/dbmate/releases/latest/download/dbmate-macos-amd64
	chmod +x dbmate
	./dbmate --help

dbmate-download-cached:
	if [ ! -f dbmate ]; then \
		make dbmate-download; \
	fi

dbmate-up:
	make dbmate-download-cached

	mkdir -p db && ./dbmate --url "sqlite:db/db.sqlite3" up

dbmate-new:
	make dbmate-download-cached
	mkdir -p db && ./dbmate --url "sqlite:db/db.sqlite3" new "new-migration-rename-me"

dbmate-down:
	./dbmate --url "sqlite:db/db.sqlite3" down

	mkdir -p db && ./dbmate --url "sqlite:db/db.sqlite3" down

tw-download:
	curl -fsSL -o tailwindcss https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-macos-arm64
	chmod +x tailwindcss
	./tailwindcss --help

tw-build:
	./tailwindcss -i ./public/input.css -o ./public/output.css --minify

tw-download-cached:
	if [ ! -f tailwindcss ]; then \
		make tw-download; \
	fi

tw:
	make tw-download-cached
	./tailwindcss -i ./public/input.css -o ./public/output.css --minify --watch