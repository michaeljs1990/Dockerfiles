# Dockerfiles

Collection of Dockerfiles

#### Phabricator

A phabricator development dockerfile. Currently no sutable version of phabricator in docker exists. This is the closest one to being fully functional however it has some issues to work out still such as email and i'm sure many others. As I work on phabricator this will get closer to being production ready.

#### Zookeeper

A zookeeper cluster that can be easily use for development with `docker-compose up`. It tries to look as much like a zookeeper cluster would in production outside of logging set to INFO.

#### Kea DHCPD

A early start of getting Kea DHCPD up and running in a docker contianer. Read more about it at the README in the directory.
