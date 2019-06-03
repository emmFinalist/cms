FROM drupal:8.7.1-fpm-alpine

COPY ./data/sites /var/www/html/sites
RUN chown www-data:www-data -R /var/www/html/sites/ && \
    chmod -R 755 /var/www/html/sites/

USER www-data