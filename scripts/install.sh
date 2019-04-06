#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Paths relative to root.

# WordPress.
vendor/bin/wp core install --path=$WP_WEBROOT --url=localhost:8000 \
  --title=wordhat --skip-email \
  --admin_email=wordpress@example.com \
  --admin_user=admin --admin_password=password
