FROM drupal:8.7.1-apache

COPY ./data/sites /var/www/html/sites
RUN mkdir -p /var/www/html/sites/default/files/config_fc4qK3oeMQsTPc9fzDF3H5T9s_AsAts6c6spw03EGzyaD4cO1cZ8N5ejApNBHDqmbveL7kge-g/sync
RUN chmod -R 777 /var/www/html/sites