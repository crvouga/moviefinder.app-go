
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
	make build & make run