FROM drupal:8.7.5-apache

# Set workdir
WORKDIR /var/www/html/
ENV COMPOSER_ALLOW_SUPERUSER 1
# Install composer, require the elasticsearch dependencies
RUN apt update && apt install -y git unzip
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer config --global repo.packagist composer https://packagist.org
RUN composer require 'drupal/console:~1.0' --prefer-dist --optimize-autoloader
RUN curl https://drupalconsole.com/installer -L -o drupal.phar && \
    mv drupal.phar /usr/local/bin/drupal && \
    chmod +x /usr/local/bin/drupal

RUN composer --no-ansi require 'drupal/elasticsearch_connector:^5.0'
RUN composer --no-ansi require 'drupal/search_api:^1.8'
RUN drupal module:install elasticsearch_connector search_api

COPY data/php/uploads.ini /usr/local/etc/php/conf.d/uploads.ini
COPY data/sites /template/sites
RUN mkdir -p /app/shared
RUN \
  for I in modules profiles sites themes; do \
    rm -rf /var/www/html/$I; \
    ln -s /app/shared/$I /var/www/html/$I; \
  done


COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
CMD ["/bin/bash","-c","/entrypoint.sh"]
