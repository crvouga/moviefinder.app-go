#!/bin/bash
set -e

# PostgreSQL configuration
POSTGRES_USER="${POSTGRES_USER:-postgres}"
POSTGRES_PASSWORD="${POSTGRES_PASSWORD:-postgres}"
POSTGRES_DB="${POSTGRES_DB:-postgres}"
POSTGRES_DATA_DIR="${POSTGRES_DATA_DIR:-/tmp/postgres-data}"
POSTGRES_HOST="${POSTGRES_HOST:-localhost}"
POSTGRES_PORT="${POSTGRES_PORT:-5432}"

# Find PostgreSQL binaries directory
# In Debian, PostgreSQL binaries are in /usr/lib/postgresql/<version>/bin/ or /usr/bin/
PG_BIN=""
if [ -d /usr/lib/postgresql ]; then
    PG_VERSION=$(ls -1 /usr/lib/postgresql 2>/dev/null | head -n1)
    if [ -n "$PG_VERSION" ] && [ -d "/usr/lib/postgresql/${PG_VERSION}/bin" ]; then
        PG_BIN="/usr/lib/postgresql/${PG_VERSION}/bin"
    fi
fi

# Fallback to /usr/bin if versioned path not found
if [ -z "$PG_BIN" ] || [ ! -f "$PG_BIN/initdb" ]; then
    if [ -f "/usr/bin/initdb" ]; then
        PG_BIN="/usr/bin"
    else
        # Try to find initdb in PATH
        INITDB_PATH=$(command -v initdb 2>/dev/null || echo "")
        if [ -n "$INITDB_PATH" ] && [ -f "$INITDB_PATH" ]; then
            PG_BIN=$(dirname "$INITDB_PATH")
        else
            echo "Error: Could not find PostgreSQL binaries (initdb not found)"
            echo "Searched in: /usr/lib/postgresql/*/bin, /usr/bin, and PATH"
            exit 1
        fi
    fi
fi

# Export PG_BIN for use in functions
export PG_BIN
echo "Using PostgreSQL binaries from: $PG_BIN"

# Database URL for the application
export DATABASE_URL="postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}?sslmode=disable"

# Function to initialize PostgreSQL data directory
init_postgres() {
    if [ ! -d "$POSTGRES_DATA_DIR" ] || [ -z "$(ls -A $POSTGRES_DATA_DIR 2>/dev/null)" ]; then
        echo "Initializing PostgreSQL data directory at $POSTGRES_DATA_DIR..."
        mkdir -p "$POSTGRES_DATA_DIR"
        chown -R postgres:postgres "$POSTGRES_DATA_DIR"
        
        # Initialize database cluster
        gosu postgres "$PG_BIN/initdb" -D "$POSTGRES_DATA_DIR"
        
        # Configure PostgreSQL to listen on localhost
        # Use trust for localhost initially so we can set password, then change to scram-sha-256
        echo "host all all 127.0.0.1/32 trust" >> "$POSTGRES_DATA_DIR/pg_hba.conf"
        echo "host all all ::1/128 trust" >> "$POSTGRES_DATA_DIR/pg_hba.conf"
        echo "listen_addresses = 'localhost'" >> "$POSTGRES_DATA_DIR/postgresql.conf"
        echo "port = $POSTGRES_PORT" >> "$POSTGRES_DATA_DIR/postgresql.conf"
    fi
}

# Function to start PostgreSQL
start_postgres() {
    echo "Starting PostgreSQL..."
    gosu postgres "$PG_BIN/postgres" -D "$POSTGRES_DATA_DIR" &
    POSTGRES_PID=$!
    
    # Wait for PostgreSQL to be ready
    echo "Waiting for PostgreSQL to be ready..."
    for i in {1..30}; do
        if gosu postgres "$PG_BIN/pg_isready" -h "$POSTGRES_HOST" -p "$POSTGRES_PORT" > /dev/null 2>&1; then
            echo "PostgreSQL is ready!"
            return 0
        fi
        sleep 1
    done
    
    echo "PostgreSQL failed to start within 30 seconds"
    return 1
}

# Function to set password and create database if needed
setup_database() {
    echo "Setting up database..."
    # Set password for postgres user
    gosu postgres "$PG_BIN/psql" -d postgres <<-EOSQL
        ALTER USER $POSTGRES_USER WITH PASSWORD '$POSTGRES_PASSWORD';
EOSQL
    
    # Create database if it doesn't exist (postgres database already exists, but check for custom DB)
    if [ "$POSTGRES_DB" != "postgres" ]; then
        gosu postgres "$PG_BIN/psql" -d postgres <<-EOSQL
            SELECT 'CREATE DATABASE $POSTGRES_DB'
            WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '$POSTGRES_DB')\gexec
EOSQL
    fi
    
    # Update pg_hba.conf to use scram-sha-256 now that password is set
    sed -i 's/host all all 127\.0\.0\.1\/32 trust/host all all 127.0.0.1\/32 scram-sha-256/' "$POSTGRES_DATA_DIR/pg_hba.conf"
    sed -i 's/host all all ::1\/128 trust/host all all ::1\/128 scram-sha-256/' "$POSTGRES_DATA_DIR/pg_hba.conf"
    
    # Reload PostgreSQL configuration
    gosu postgres "$PG_BIN/pg_ctl" -D "$POSTGRES_DATA_DIR" reload > /dev/null 2>&1 || true
}

# Function to stop PostgreSQL gracefully
stop_postgres() {
    if [ -n "$POSTGRES_PID" ]; then
        echo "Stopping PostgreSQL (PID: $POSTGRES_PID)..."
        kill -TERM "$POSTGRES_PID" 2>/dev/null || true
        wait "$POSTGRES_PID" 2>/dev/null || true
        echo "PostgreSQL stopped"
    fi
}

# Trap signals to gracefully shutdown
trap 'stop_postgres; exit 0' SIGTERM SIGINT

# Initialize and start PostgreSQL
init_postgres
start_postgres || exit 1

# Setup database and password
setup_database || echo "Warning: Database setup may have failed, continuing anyway..."

# Change to app directory
cd /app

# Execute the main application
echo "Starting application..."
exec "$@"
