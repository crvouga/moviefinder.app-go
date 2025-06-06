# Use the official Go image as the base image
FROM golang:1.24-alpine

# Set the working directory inside the container
WORKDIR /app

# Install curl and add dbmate
RUN apk add --no-cache curl \
    && curl -fsSL -o /usr/local/bin/dbmate https://github.com/amacneil/dbmate/releases/latest/download/dbmate-linux-amd64 \
    && chmod +x /usr/local/bin/dbmate

# Copy go.mod and go.sum files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy the entire project
COPY . .

# Build the Go application
RUN go build -o main .

# Expose port 8080
EXPOSE 8080

# Command to run migrations and start the application
CMD dbmate --url "sqlite:///app/db/db.sqlite3" up && ./main
