FROM drupal:8.7.1-apache

# Install git. This is needed by some of the dependencies of the S3 File System module
# RUN apt-get update; \
# 	apt-get install -y --no-install-recommends git; \
#     apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
# 	rm -rf /var/lib/apt/lists/*

COPY ./data/sites /var/www/html/sites
RUN mkdir -p /var/www/html/sites/default/files/config_fc4qK3oeMQsTPc9fzDF3H5T9s_AsAts6c6spw03EGzyaD4cO1cZ8N5ejApNBHDqmbveL7kge-g/sync
RUN chmod -R 777 /var/www/html/sites

WORKDIR /var/www/html/
# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# RUN composer require --no-suggest  --no-update --no-interaction 'drupal/s3fs:^3.0'

# Deny write access to config files as recommended by Drupal
RUN chmod ugo-w sites/default/settings.php sites/default