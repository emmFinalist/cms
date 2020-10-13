FROM drupal:9.0.7-apache

RUN apt update && apt install -y git unzip

COPY data/php/conf.d/uploads.ini /usr/local/etc/php/conf.d/uploads.ini

WORKDIR /var/www/html/

RUN curl -sS https://getcomposer.org/installer | php

COPY composer.json composer.lock ./

RUN composer install --ansi --no-interaction --no-cache --no-suggest --no-plugins

RUN rm -rf core db

RUN \
  for I in profiles sites; do \
  rm -rf /var/www/html/$I; \
  ln -s /app/shared/$I /var/www/html/$I; \
  done

COPY data/sites /template/sites
COPY app/config /app/config
COPY app/themes /app/themes

RUN rm -rf /var/www/html/modules && \
  mv -r /var/www/html/vendor/drupal /var/www/html/modules

RUN ln -s /app/themes /var/www/html/themes

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

COPY data/apache/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod proxy proxy_http cache_disk headers

CMD [ "/entrypoint.sh"]
