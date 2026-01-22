# Build stage
FROM golang:1.24 AS builder

WORKDIR /build

# Copy go mod files
COPY go.mod go.sum ./
RUN go mod download

# Copy source code
COPY . .

# Build Go application
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main main.go

# Runtime stage
FROM debian:bookworm-slim

# Install PostgreSQL, ca-certificates, wget, and gosu for running PostgreSQL as non-root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    postgresql \
    postgresql-client \
    ca-certificates \
    wget \
    gosu \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy binary from builder
COPY --from=builder /build/main .

# Copy app directory with HTML templates (needed at runtime for template loading)
# Must maintain same path structure as build stage since runtime.Caller() uses compile-time paths
COPY --from=builder /build/app /build/app

# Copy public directory with static assets
COPY --from=builder /build/public ./public

# Copy startup script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Expose ports (8080 for app, 5432 for PostgreSQL - though PostgreSQL only listens on localhost)
EXPOSE 8080 5432

# Set entrypoint to startup script
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# Run the application
CMD ["./main"]
