Drupal die in een Docker container draait. De bedoeling is dat Drupal wordt _headless_ gebruikt (dat wil zeggen, zonder user interace).

Zie de [officiele Drupal container](https://hub.docker.com/_/drupal/) op Docker Hub.

Gebruik de `docker-compose` in je eigen ontwikkelomgeving. Deze start drupal, nginx en postgres op.

## To do
- Voeg een module toe aan Drupal om Openstack/ObjectStorage (Swift) te kunnen gebruiken. Zie bijvoorbeeld:
  *  [Flysystem](https://www.drupal.org/project/flysystem)


## Variables

  * CLOUDFUSE_USER
  * CLOUDFUSE_PASSWORD
  * CLOUDFUSE_TENANT
