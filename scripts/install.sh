#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Paths relative to root.

# WordPress.
vendor/bin/wp core install --path=$WP_WEBROOT --url=localhost:8000 \
  --title=wordhat --skip-email \
  --admin_email=wordpress@example.com \
  --admin_user=admin --admin_password=password

# Sane defaults.
vendor/bin/wp theme activate --path=$WP_WEBROOT twentyseventeen
vendor/bin/wp rewrite structure --path=$WP_WEBROOT '/%year%/%monthnum%/%postname%/'
curl -o ${WP_WEBROOT}/wp-content/mu-plugins/disable-gutenberg.php https://gist.githubusercontent.com/paulgibbs/6d6309e0ea586d955e0b7b5573d5a642/raw/f8961ab10b818379c209359b36d9ad0d4ed9bbde/disable-gutenberg.php

# The default widgets often repeat post titles and confuse Behat.
for sidebar in $(vendor/bin/wp sidebar list --path=$WP_WEBROOT --format=ids); do
  for widget in $(vendor/bin/wp widget list $sidebar --path=$WP_WEBROOT --format=ids); do
    vendor/bin/wp widget delete --path=$WP_WEBROOT $widget
  done;
done;
