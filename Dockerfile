FROM drupal:8.7.1-apache

COPY ./data/sites /var/www/html/sites
RUN mkdir /var/www/html/sites/default/files/config/sync && chmod -R 755 /var/www/html/sites