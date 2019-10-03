FROM aditudorache/drupal:8.7.7

COPY data/php/conf.d/uploads.ini /usr/local/etc/php/conf.d/uploads.ini
COPY data/sites /template/sites
COPY app/modules /app/modules
COPY app/config /app/config
COPY app/themes /app/themes

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

# Extra Apache configs
COPY data/apache/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod proxy proxy_http

ENTRYPOINT [ "/entrypoint.sh"]
