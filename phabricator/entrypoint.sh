#!/bin/bash
# Move config file in place so we can connect to mysql and
# Run migrations if they are needed.
cp -f /local.json /phacility/phabricator/conf/local/local.json
# Run migrations without a prompt
/phacility/phabricator/bin/storage upgrade --force
# Run supervisord in the foreground
exec supervisord --nodaemon -c /usr/local/etc/supervisord.conf
