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


## Overview of the installed modules

This list is generated from an runing version of Drupal with

```bash
 drush pm-list --type=Module --status=enabled
```

Update this list each time a module is installed/updated

 ---------------- ----------------------------------------------------------- --------- ----------------
  Package          Name                                                        Status    Version
 ---------------- ----------------------------------------------------------- --------- ----------------
  Core             Automated Cron (automated_cron)                             Enabled   8.9.0
  Core             BigPipe (big_pipe)                                          Enabled   8.9.0
  Core             Block (block)                                               Enabled   8.9.0
  Core             Custom Block (block_content)                                Enabled   8.9.0
  Core             Breakpoint (breakpoint)                                     Enabled   8.9.0
  Core             CKEditor (ckeditor)                                         Enabled   8.9.0
  Core             Color (color)                                               Enabled   8.9.0
  Core             Comment (comment)                                           Enabled   8.9.0
  Core             Configuration Manager (config)                              Enabled   8.9.0
  Core             Contact (contact)                                           Enabled   8.9.0
  Core             Contextual Links (contextual)                               Enabled   8.9.0
  Field types      Datetime (datetime)                                         Enabled   8.9.0
  Core             Database Logging (dblog)                                    Enabled   8.9.0
  Core             Internal Dynamic Page Cache (dynamic_page_cache)            Enabled   8.9.0
  Core             Text Editor (editor)                                        Enabled   8.9.0
  Core             Field (field)                                               Enabled   8.9.0
  Core             Field UI (field_ui)                                         Enabled   8.9.0
  Field types      File (file)                                                 Enabled   8.9.0
  Core             Filter (filter)                                             Enabled   8.9.0
  Core             Help (help)                                                 Enabled   8.9.0
  Core             History (history)                                           Enabled   8.9.0
  Field types      Image (image)                                               Enabled   8.9.0
  Web services     JSON:API (jsonapi)                                          Enabled   8.9.0
  Field types      Link (link)                                                 Enabled   8.9.0
  Core             Media (media)                                               Enabled   8.9.0
  Core             Media Library (media_library)                               Enabled   8.9.0
  Core             Custom Menu Links (menu_link_content)                       Enabled   8.9.0
  Core             Menu UI (menu_ui)                                           Enabled   8.9.0
  Core             Node (node)                                                 Enabled   8.9.0
  Field types      Options (options)                                           Enabled   8.9.0
  Core             Internal Page Cache (page_cache)                            Enabled   8.9.0
  Core             Path (path)                                                 Enabled   8.9.0
  Core             Path alias (path_alias)                                     Enabled   8.9.0
  Core             Quick Edit (quickedit)                                      Enabled   8.9.0
  Core             RDF (rdf)                                                   Enabled   8.9.0
  Web services     RESTful Web Services (rest)                                 Enabled   8.9.0
  Core             Search (search)                                             Enabled   8.9.0
  Web services     Serialization (serialization)                               Enabled   8.9.0
  Core             Shortcut (shortcut)                                         Enabled   8.9.0
  Core             System (system)                                             Enabled   8.9.0
  Core             Taxonomy (taxonomy)                                         Enabled   8.9.0
  Field types      Text (text)                                                 Enabled   8.9.0
  Core             Toolbar (toolbar)                                           Enabled   8.9.0
  Core             Tour (tour)                                                 Enabled   8.9.0
  Core             Update Manager (update)                                     Enabled   8.9.0
  Core             User (user)                                                 Enabled   8.9.0
  Core             Views (views)                                               Enabled   8.9.0
  Core             Views UI (views_ui)                                         Enabled   8.9.0
  Other            Backup and Migrate (backup_migrate)                         Enabled   8.x-4.1
  Other            Configuration Update Base (config_update)                   Enabled   8.x-1.7
  Web services     Consumer Image Styles (consumer_image_styles)               Enabled   8.x-3.0
  Authentication   Consumers (consumers)                                       Enabled   8.x-1.11
  Elasticsearch    Elasticsearch Connector (elasticsearch_connector)           Enabled   8.x-6.0-alpha2
  Other            Entity Count (entity_count)                                 Enabled   8.x-1.0
  Field types      Entity Reference Revisions (entity_reference_revisions)     Enabled   8.x-1.8
  Feeds            Feeds (feeds)                                               Enabled   8.x-3.0-alpha8
  Media            Imce File Manager (imce)                                    Enabled   8.x-1.8
  Web services     JSON:API Extras (jsonapi_extras)                            Enabled   8.x-3.14
  Web services     JSON API Defaults (jsonapi_defaults)                        Enabled   8.x-3.14
  Paragraphs       Paragraphs Type Permissions (paragraphs_type_permissions)   Enabled   8.x-1.12
  Paragraphs       Paragraphs (paragraphs)                                     Enabled   8.x-1.12
  Other            REST Absolute URLs (rest_absolute_urls)                     Enabled   8.x-1.0-beta1
  Search           Search API (search_api)                                     Enabled   8.x-1.17
  Other            Typed Data (typed_data)                                     Enabled   8.x-1.0-alpha5
  Other            UUID extra (uuid_extra)                                     Enabled   8.x-1.0-beta1
 ---------------- ----------------------------------------------------------- --------- ----------------

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


