FROM golang:1.24-alpine

# Enable CGO and install build dependencies
RUN apk add --no-cache gcc musl-dev sqlite-dev

ENV CGO_ENABLED=1

WORKDIR /app
COPY . .

RUN go build -o main .

EXPOSE 8080
CMD ["./main"]