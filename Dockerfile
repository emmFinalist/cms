FROM drupal:8.7.3-apache

# Set workdir
WORKDIR /var/www/html/

# Install composer, require the elasticsearch dependencies
RUN apt update && apt install -y git unzip
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer require 'drupal/elasticsearch_connector:^5.0'
RUN composer require 'drupal/search_api:^1.8'


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
