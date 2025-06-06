# Use the official Go image as the base image
FROM golang:1.24-alpine

# Set the working directory inside the container
WORKDIR /app

# Install curl and tailwindcss
RUN apk add --no-cache curl \
    && curl -fsSL -o /usr/local/bin/tailwindcss https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-x64 \
    && chmod +x /usr/local/bin/tailwindcss

# Copy go.mod and go.sum files
COPY go.mod go.sum ./

# Download Go module dependencies
RUN go mod download

# Copy the source code into the container
COPY . .

# Build the Go application and run tailwindcss
RUN go build -o main . \
    && tailwindcss -i ./public/input.css -o ./public/output.css --minify

# Expose port 8080 for the server
EXPOSE 8080

# Command to run the executable
CMD ["./main"]
