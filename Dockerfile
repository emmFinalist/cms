FROM drupal:8.7.6-apache

RUN apt-get update && apt install -y \
	git \
 && rm -rf /var/lib/apt/lists/*

# Set workdir
WORKDIR /var/www/html/

# install Composer 1.9.0
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl --silent --fail --location --retry 3 --output /tmp/installer.php --url https://getcomposer.org/installer \
 && php /tmp/installer.php --no-ansi --install-dir=/usr/bin --filename=composer \
 && composer --ansi --version --no-interaction \
 && rm -f /tmp/installer.php \
 && find /tmp -type d -exec chmod -v 1777 {} +

COPY data/php/uploads.ini /usr/local/etc/php/conf.d/uploads.ini
COPY data/sites /template/sites
RUN mkdir -p /app/shared
RUN \
  for I in modules profiles sites themes; do \
    rm -rf /var/www/html/$I; \
    ln -s /app/shared/$I /var/www/html/$I; \
  done

RUN composer require --no-suggest --no-interaction webonyx/graphql-php

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
CMD ["/bin/bash","-c","/entrypoint.sh"]
