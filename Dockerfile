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
FROM alpine:latest

# Install ca-certificates for HTTPS requests and wget for healthcheck
RUN apk --no-cache add ca-certificates wget

WORKDIR /app

# Copy binary from builder
COPY --from=builder /build/main .

# Copy app directory with HTML templates (needed at runtime for template loading)
# Must maintain same path structure as build stage since runtime.Caller() uses compile-time paths
COPY --from=builder /build/app /build/app

# Copy public directory with static assets
COPY --from=builder /build/public ./public

# Expose port (default 8080, but can be overridden via PORT env var)
EXPOSE 8080

# Run the application
CMD ["./main"]
