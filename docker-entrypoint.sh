#!/bin/sh
set -e

if [ -z "${DATABASE_URL:-}" ]; then
  echo "ERROR: DATABASE_URL is required (use db/docker-compose.yml for local Postgres)" >&2
  exit 1
fi

cd /app
exec "$@"
