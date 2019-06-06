FROM drupal:8.7.1-apache

COPY ./data/sites /var/www/html/sites
WORKDIR /var/www/html
RUN mkdir -p sites/default/files/config/sync && chmod -R 755 sites && chown -R www-data:www-data .

USER www-data