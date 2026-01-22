# Build stage
FROM golang:1.24-alpine AS builder

# Install build dependencies
RUN apk add --no-cache curl

WORKDIR /build

# Copy go mod files
COPY go.mod go.sum ./
RUN go mod download

# Download Tailwind CSS for Linux 64-bit
RUN curl -fsSL -o tailwindcss https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-x64 && \
    chmod +x tailwindcss

# Copy source code
COPY . .

# Build Tailwind CSS
RUN ./tailwindcss -i ./public/input.css -o ./public/output.css --minify

# Build Go application
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main main.go

# Runtime stage
FROM alpine:latest

# Install ca-certificates for HTTPS requests and wget for healthcheck
RUN apk --no-cache add ca-certificates wget

WORKDIR /app

# Copy binary from builder
COPY --from=builder /build/main .

# Copy public directory with built CSS
COPY --from=builder /build/public ./public

# Expose port (default 8080, but can be overridden via PORT env var)
EXPOSE 8080

# Run the application
CMD ["./main"]
