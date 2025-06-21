FROM golang:1.24-alpine

WORKDIR /app

RUN apk add --no-cache curl \
    && curl -fsSL -o /usr/local/bin/dbmate https://github.com/amacneil/dbmate/releases/latest/download/dbmate-linux-amd64 \
    && chmod +x /usr/local/bin/dbmate

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN go build -o main .

EXPOSE 8080

ENV DATABASE_URL=$DATABASE_URL

CMD dbmate --url $DATABASE_URL up && ./main
