FROM drupal:9.0.7-apache

# ENV COMPOSER_MEMORY_LIMIT -1

RUN apt update && apt install -y git unzip

COPY data/php/conf.d/uploads.ini /usr/local/etc/php/conf.d/uploads.ini
COPY data/sites /template/sites
COPY app/modules /app/modules
COPY app/config /app/config
COPY app/themes /app/themes

WORKDIR /var/www/html/

RUN curl -sS https://getcomposer.org/installer | php

COPY composer.json composer.lock ./

RUN composer install --ansi --no-interaction --no-cache --no-suggest --no-plugins

RUN \
  for I in profiles sites; do \
  rm -rf /var/www/html/$I; \
  ln -s /app/shared/$I /var/www/html/$I; \
  done \
  && rm -rf /var/www/html/modules \
  && ln -s /app/modules /var/www/html/modules \
  && ln -s /app/themes /var/www/html/themes

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

COPY data/apache/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod proxy proxy_http cache_disk headers

CMD [ "/entrypoint.sh"]
