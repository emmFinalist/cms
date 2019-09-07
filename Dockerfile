FROM aditudorache/drupal:8.7.7

COPY data/php/conf.d/uploads.ini /usr/local/etc/php/conf.d/uploads.ini
COPY data/sites /template/sites
COPY app/modules /app/modules

RUN \
  for I in profiles sites themes; do \
    rm -rf /var/www/html/$I; \
    ln -s /app/shared/$I /var/www/html/$I; \
  done \
  && rm -rf /var/www/html/modules \
  && ln -s /app/modules /var/www/html/modules

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh"]
