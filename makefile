
run:
	go run main.go

dev:
	air

test:
	go test ./... -v

build:
	go build -o main main.go

clean:
	rm -f main
	rm -rf tmp

.PHONY: run dev test build clean
