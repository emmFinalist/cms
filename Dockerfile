FROM aditudorache/drupal:8

COPY data/php/conf.d/uploads.ini /usr/local/etc/php/conf.d/uploads.ini
COPY data/sites /template/sites
COPY app/shared/modules /app/shared/modules

RUN \
  for I in modules profiles sites themes; do \
    rm -rf /var/www/html/$I; \
    ln -s /app/shared/$I /var/www/html/$I; \
  done

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh"]
