FROM drupal:8.7.5-apache

# Set workdir
WORKDIR /var/www/html/
ENV COMPOSER_ALLOW_SUPERUSER 1

# Disable the ssl verification on git clone
# ENV GIT_SSL_NO_VERIFY 1

RUN apt update && apt install -y git unzip

# Install composer, require the elasticsearch dependencies
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install drupal cli
RUN composer config --global repo.packagist composer https://packagist.org
RUN composer require 'drupal/console:~1.0' --prefer-dist --optimize-autoloader --no-ansi 
RUN curl https://drupalconsole.com/installer -L -o drupal.phar && \
    mv drupal.phar /usr/local/bin/drupal && \
    chmod +x /usr/local/bin/drupal

RUN composer require 'drupal/elasticsearch_connector:^5.0' --no-ansi 
RUN composer require 'drupal/search_api:^1.8' --no-ansi 

COPY data/php/uploads.ini /usr/local/etc/php/conf.d/uploads.ini
COPY data/sites /template/sites
RUN mkdir -p /app/shared
RUN \
  for I in modules profiles sites themes; do \
    rm -rf /var/www/html/$I; \
    ln -s /app/shared/$I /var/www/html/$I; \
  done

# Disable the installation of the modules. Will be implemented later when the build is working
#RUN drupal module:uninstall search
#RUN drupal module:install elasticsearch_connector search_api

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
CMD ["/bin/bash","-c","/entrypoint.sh"]
