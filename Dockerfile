FROM drupal:8.7.6-apache

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
RUN composer require drupal/coder --no-ansi
RUN composer require 'drupal/console:~1.0' --prefer-dist --optimize-autoloader --no-ansi 
RUN curl https://drupalconsole.com/installer -L -o drupal.phar && \
    mv drupal.phar /usr/local/bin/drupal && \
    chmod +x /usr/local/bin/drupal

# Install drush cli
RUN curl -OL https://github.com/drush-ops/drush-launcher/releases/download/0.6.0/drush.phar
RUN mv drush.phar /usr/local/bin/drush && \
    chmod +x /usr/local/bin/drush
RUN composer require drush/drush

RUN composer require "drupal/elasticsearch_connector:^6" --no-ansi 
RUN composer require "nodespark/des-connector:^6" --no-ansi 
RUN composer require drupal/search_api --no-ansi 
RUN composer require webonyx/graphql-php  --no-ansi 
RUN composer require drupal/graphql_search_api --no-ansi
RUN composer update

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
#RUN drupal module:install elasticsearch_connector search_api grapshql_core graphql_search_api
#RUN drush cr

#RUN drupal module:uninstall graphql_search_api grapshql_core graphql search_api elasticsearch_connector

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
CMD ["/bin/bash","-c","/entrypoint.sh"]
