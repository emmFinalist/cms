FROM drupal:8.7.1-apache

# Set workdir
WORKDIR /var/www/html/

COPY data/sites /template/sites
RUN mkdir -p /app/shared
RUN \
  for I in modules profiles sites themes; do \
    rm -rf /var/www/html/$I; \
    ln -s /app/shared/$I /var/www/html/$I; \
  done

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
CMD ["/bin/bash","-c","/entrypoint.sh"]
