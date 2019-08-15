FROM aditudorache:drupal

# Disable the installation of the modules. Will be implemented later when the build is working
#RUN drupal module:uninstall search
#RUN drupal module:install elasticsearch_connector search_api grapshql_core graphql_search_api
#RUN drush cr

#RUN drupal module:uninstall graphql_search_api grapshql_core graphql search_api elasticsearch_connector

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh"]
