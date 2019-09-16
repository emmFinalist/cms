# Drupal cms for the Amsterdam `OIS Dataportaal`

This is the implementation of a headless cms for the `Dataportaal` of the Municipality of Amsterdam where articles, publications and special articles will be published and maintained.
This is based on the Drupal cms enriched with Elasticsearch capabilities.

## Architecture

The cms backend will be used by the OIS Editors to publish the editorial material. The editorial material will be made available through the headless API of Drupal and integrated in the [`Dataportaal` website](https://data.amsterdam.nl)

## Development

Use the docker-compose commands to spin up the development environment.
Run for instance `docker-compose up -d` to run a detached local instance.

## Installation

After the website is started, this can be extended with modules. The modules that don't have a core dependency can be installed by loading in the admin panel in drupal.
There are few modules that have to be installed from inside the container by executing drupal console launcher commands.
These modules are elasticsearch_connector, search_api, graphql and graphql_search_api and will be described in a separate chapter

## Deployment and synchronizaton acceptance and production

Synchronyze the site uuid among development, accepance(staging) and production
Use these commands to achieve get and set the site uuid.

```bash
drush config-get "system.site" uuid # 8b6c1207-98d1-45fe-89f9-6a5d6517ab52
drush config-set "system.site" uuid "8b6c1207-98d1-45fe-89f9-6a5d6517ab52"
```

After the deployment, the new installed modules have to be manually installed from the extension manager or through configuration synchronization.

For development, set in the docker-compose the `DRUPAL_HASH_SALT` environment variable to the generated value from the build pipeline.
Export and import the configuration with the synchronization panel `/admin/config/development/configuration`

## Overview of the installed modules

This list is generated from an runing version of Drupal with

```bash
 drush pm-list --type=Module --status=enabled
```

Update this list each time a module is installed/updated

 --------------------- --------------------------------------------------- --------- ---------------- 
  Package               Name                                                Status    Version         
 --------------------- --------------------------------------------------- --------- ---------------- 
  Core                  Automated Cron (automated_cron)                     Enabled   8.7.7           
  Core                  BigPipe (big_pipe)                                  Enabled   8.7.7           
  Core                  Block (block)                                       Enabled   8.7.7           
  Core                  Custom Block (block_content)                        Enabled   8.7.7           
  Core                  Breakpoint (breakpoint)                             Enabled   8.7.7           
  Core                  CKEditor (ckeditor)                                 Enabled   8.7.7           
  Core                  Color (color)                                       Enabled   8.7.7           
  Core                  Comment (comment)                                   Enabled   8.7.7           
  Core                  Configuration Manager (config)                      Enabled   8.7.7           
  Core                  Contact (contact)                                   Enabled   8.7.7           
  Core                  Contextual Links (contextual)                       Enabled   8.7.7           
  Field types           Datetime (datetime)                                 Enabled   8.7.7           
  Core                  Database Logging (dblog)                            Enabled   8.7.7           
  Core                  Internal Dynamic Page Cache (dynamic_page_cache)    Enabled   8.7.7           
  Core                  Text Editor (editor)                                Enabled   8.7.7           
  Core                  Field (field)                                       Enabled   8.7.7           
  Core                  Field UI (field_ui)                                 Enabled   8.7.7           
  Field types           File (file)                                         Enabled   8.7.7           
  Core                  Filter (filter)                                     Enabled   8.7.7           
  Core                  Help (help)                                         Enabled   8.7.7           
  Core                  History (history)                                   Enabled   8.7.7           
  Field types           Image (image)                                       Enabled   8.7.7           
  Web services          JSON:API (jsonapi)                                  Enabled   8.7.7           
  Field types           Link (link)                                         Enabled   8.7.7           
  Core                  Media (media)                                       Enabled   8.7.7           
  Core (Experimental)   Media Library (media_library)                       Enabled   8.7.7           
  Core                  Custom Menu Links (menu_link_content)               Enabled   8.7.7           
  Core                  Menu UI (menu_ui)                                   Enabled   8.7.7           
  Core                  Node (node)                                         Enabled   8.7.7           
  Field types           Options (options)                                   Enabled   8.7.7           
  Core                  Internal Page Cache (page_cache)                    Enabled   8.7.7           
  Core                  Path (path)                                         Enabled   8.7.7           
  Core                  Quick Edit (quickedit)                              Enabled   8.7.7           
  Core                  RDF (rdf)                                           Enabled   8.7.7           
  Web services          RESTful Web Services (rest)                         Enabled   8.7.7           
  Core                  Search (search)                                     Enabled   8.7.7           
  Web services          Serialization (serialization)                       Enabled   8.7.7           
  Core                  Shortcut (shortcut)                                 Enabled   8.7.7           
  Core                  System (system)                                     Enabled   8.7.7           
  Core                  Taxonomy (taxonomy)                                 Enabled   8.7.7           
  Field types           Text (text)                                         Enabled   8.7.7           
  Core                  Toolbar (toolbar)                                   Enabled   8.7.7           
  Core                  Tour (tour)                                         Enabled   8.7.7           
  Core                  Update Manager (update)                             Enabled   8.7.7           
  Core                  User (user)                                         Enabled   8.7.7           
  Core                  Views (views)                                       Enabled   8.7.7           
  Core                  Views UI (views_ui)                                 Enabled   8.7.7           
  Other                 Configuration Update Base (config_update)           Enabled   8.x-1.6         
  Web services          Consumer Image Styles (consumer_image_styles)       Enabled   8.x-3.0         
  Authentication        Consumers (consumers)                               Enabled   8.x-1.9         
  Elasticsearch         Elasticsearch Connector (elasticsearch_connector)   Enabled   8.x-6.0-alpha2  
  Other                 Entity Count (entity_count)                         Enabled   8.x-1.0         
  Feeds                 Feeds (feeds)                                       Enabled   8.x-3.0-alpha5  
  Media                 Imce File Manager (imce)                            Enabled   8.x-1.7         
  Web services          JSON:API Extras (jsonapi_extras)                    Enabled   8.x-3.10        
  Web services          JSON API Defaults (jsonapi_defaults)                Enabled   8.x-3.10        
  Other                 REST Absolute URLs (rest_absolute_urls)             Enabled   8.x-1.0-beta1   
  Search                Search API (search_api)                             Enabled   8.x-1.14        
  Other                 Typed Data (typed_data)                             Enabled   8.x-1.0-alpha3  
 --------------------- --------------------------------------------------- --------- ---------------- 

## Update procedure

This workflow can be used for both updating/upgrading of a module or changing the settings for elasticsearch

- Start local a instance of the system

```bash
 docker-compose up -d
```

- Make the requested changes and test that it works. This step can be a local change or an import of the exported acceptance configuration
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


