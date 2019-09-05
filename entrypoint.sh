#!/bin/sh
for I in modules profiles sites themes; do \
  mkdir -p /app/shared/$I
done
 
if [ ! -d /app/shared/sites/default ]; then
  cp -rv /template/sites/* /app/shared/sites/
fi

chown -R www-data:www-data /app/shared/*

# Startup Script
apache2-foreground
