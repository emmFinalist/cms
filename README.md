# Drupal cms for the Amsterdam OIS Dataportaal

This is the implementation of a headless cms for the Dataportaal of the Municipality of Amsterdam where articles, publications and special articles will be published and maintained.
This is based on the Drupal cms enriched with Elasticsearch and GraphQL capabilities.

## Architecture

The cms backend will be used by the OIS Editors to publish the editorial material. The editorial material will be made available through the headless API of Drupal and integrated in the [Dataportaal website](https://data.amsterdam.nl)

## Development

Use the docker-compose commands to spin up the development environment.
Run for instance `docker-compose up -d` to run a detached local instance.

## Installation

After the website is started, this can be extended with modules. The modules that don't have a core dependency can be installed by loading in the admin panel in drupal.
There are few modules that have to be installed from inside the container by executing drupal console launcher commands.
These modules are elasticsearch_connector, search_api, graphql and graphql_search_api and will be described in a separate chapter

### Overview of the extra modules installed through the admin panel

- TODO

### Overview of the steps to install the extra modules with drupal console launcher command

- connect to the docker container

```bash
docker exec -it <id> bash
```

- execute the following commands to install the modules

```bash
drupal module:install elasticsearch_connector
# select option 8.x-6.0-alpha2

drupal module:install search_api
# select option 8.x-1.14

drupal module:install graphql graphql_core graphql_search_api
```

## Deployment and synchronizaton acceptance and production

- TODO


## Extra information

The following sources have been used during the development of this project

- [elasticsearch in drupal](https://opensenselabs.com/blog/tech/use-elastic-search-indexing-drupal)
- [install composer](https://stackoverflow.com/questions/51443557/how-to-install-php-composer-inside-a-docker-container/51446468)
- [update drupal core](https://www.drupal.org/docs/8/update/update-core-via-composer)
- [graphql search api](https://graphql-search-api.readthedocs.io/en/latest/)
