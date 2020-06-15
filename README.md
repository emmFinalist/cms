# Drupal cms for the Amsterdam data portal

This is the implementation of a headless cms for the data portal of the Municipality of Amsterdam where articles, publications and other editorial content will be published and maintained.
This is based on the Drupal cms enriched with Elasticsearch capabilities.

## Architecture

The cms backend will be used by editors to publish the editorial content. The editorial content will be made available through the headless API of Drupal and integrated in the website [Data en informatie](https://data.amsterdam.nl) (the data portal).

## Development

Use the docker-compose commands to spin up the development environment.
Run for instance `docker-compose up -d` to run a detached local instance.


## Configuration synchronization

To synchronyze the site uuid among development, accepance(staging) and production use these commands to get the site uuid of the production instance and set the site uuid of the local instance.

```bash
drush config-get "system.site" uuid
drush config-set "system.site" uuid [uuid]
```

When executing from the docker host machine:

```bash
docker exec -it cms_drupal_1 drush config-set "system.site" uuid [uuid]
```

Export the production configuration using the synchronization panel `/admin/config/development/configuration`

## Update or install modules

Drupal modules can be updated or installed by adding them to `/app/modules`.

After deployment, newly installed modules may have to be manually activated from the extension manager.

When new modules are installed Drupal will ask for a database update. If needed the update can be manually initiated by navigating to `/update.php`.

When all modules are activated and the database is updated, the content can be re-indexed for Elastic Search using `/admin/config/search/search-api`.


## Overview of the installed modules

For an overview of all enabled modules in a running instance of Drupal use

```bash
 drush pm-list --type=Module --status=enabled
```

## Update procedure

This workflow can be used for both updating/upgrading of a module or changing the settings for elasticsearch

- Start local a instance of the system

```bash
 docker-compose up -d
```

- Make the requested changes and test that it works.
- The changes should be reflected in one of the `./app` directories
- Checkin the changes
- Run the Jenkins pipeline
- For both acceptance and production go the synchronize utility (`https://<site-address>/admin/config/development/configuration`) and run the synchronization
- When there are changes in the elasticsearch metadata, go the `Search API (admin/config/search/search-api)` module and reindex.

## Extra information

The following sources have been used during the development of this project

- [elasticsearch in drupal](https://opensenselabs.com/blog/tech/use-elastic-search-indexing-drupal)
- [install composer](https://stackoverflow.com/questions/51443557/how-to-install-php-composer-inside-a-docker-container/51446468)
- [update drupal core](https://www.drupal.org/docs/8/update/update-core-via-composer)


