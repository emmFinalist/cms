#/bin/sh
mkdir -p /app/shared/{modules,profiles,sites,themes}

if [ ! -d /app/shared/sites/default ]; then
  cp -rv /template/sites/* /app/shared/sites/
fi

chown -R www-data:www-data /app/shared/*

composer require --no-suggest --update-no-dev --no-interaction --no-progress \
  webonyx/graphql-php

# Startup Script
apache2-foreground
