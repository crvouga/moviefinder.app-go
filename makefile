
run:
	clear && go run main.go

build:
	make tw-build & go build -o main main.go

dev:
	air

test:
	clear && go test -v ./... | grep -E -e "--- (PASS|FAIL)|_test.go:" | sed ''/---\ PASS:/s//"$$(printf "\033[32m✅ PASS:\033[0m")"/'' | sed ''/---\ FAIL:/s//"$$(printf "\033[31m❌ FAIL:\033[0m")"/''

tc:
	clear && go vet ./...

check:
	make tc
	make test

build:
	go build -o main main.go

clean:
	rm -f main
	rm -rf tmp

.PHONY: run dev test build clean

preview:
	docker build -t moviefinder . && docker run -p 8080:8080 moviefinder

q:
	psql postgres://postgres:postgres@localhost:5433/postgres?sslmode=disable

qw:
	psql -P pager=off postgres://postgres:postgres@localhost:5433/postgres?sslmode=disable < query.sql

local-up:
	docker compose -f db/docker-compose.yml up -d

local-down:
	docker compose -f db/docker-compose.yml down

local:
	make local-down && make local-up

dbmate-download:
	curl -fsSL -o dbmate https://github.com/amacneil/dbmate/releases/latest/download/dbmate-macos-amd64
	chmod +x dbmate
	./dbmate --help

dbmate-download-cached:
	if [ ! -f dbmate ]; then \
		make dbmate-download; \
	fi

db-up:
	make dbmate-download-cached
	mkdir -p db && ./dbmate up

dbmate:
	make dbmate-download-cached
	mkdir -p db && ./dbmate new "$(filter-out $@,$(MAKECMDGOALS))"

db-down:
	./dbmate down
	mkdir -p db && ./dbmate down

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