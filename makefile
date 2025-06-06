
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

db-shell:
	sqlite3 db/db.sqlite

dbmate:
	curl -fsSL -o dbmate https://github.com/amacneil/dbmate/releases/latest/download/dbmate-macos-amd64
	chmod +x dbmate
	./dbmate --help
