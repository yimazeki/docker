#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

if [ -f .env ]; then
  echo ".env already exists. Remove it first if you want to regenerate it." >&2
  exit 1
fi

random_hex() {
  local bytes="$1"
  if command -v openssl >/dev/null 2>&1; then
    openssl rand -hex "$bytes"
  else
    head -c "$bytes" /dev/urandom | od -An -tx1 | tr -d ' \n'
  fi
}

postgres_password="$(random_hex 24)"
secret_key_base="$(random_hex 64)"
collaborative_secret="$(random_hex 32)"

sed \
  -e "s/^POSTGRES_PASSWORD=.*/POSTGRES_PASSWORD=${postgres_password}/" \
  -e "s/^SECRET_KEY_BASE=.*/SECRET_KEY_BASE=${secret_key_base}/" \
  -e "s/^COLLABORATIVE_SERVER_SECRET=.*/COLLABORATIVE_SERVER_SECRET=${collaborative_secret}/" \
  .env.example > .env

echo "Created openproject/.env"
