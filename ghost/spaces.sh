#!/bin/bash
# Backup the content folder using the digitial ocean
# spaces service API. Here is an example usage of this
# make sure to run `aws configuration` and add your key
# and secret however make sure you don't have a default
# region it seems to break using awscli with DO.
#
# ./spaces.sh `pwd`/content s3://mschuett/ghost_backups

set -euxo pipefail

REGION=${REGION:-nyc3}
DIRECTORY=$1
BUCKET=$2
FILE_NAME="ghost_content_$(date +%Y%m%d-%s).tgz"

echo "Staring backup of directory"
tar -zcf /tmp/$FILE_NAME $DIRECTORY 
aws --endpoint-url https://$REGION.digitaloceanspaces.com s3 cp /tmp/$FILE_NAME $BUCKET/$FILE_NAME
rm /tmp/$FILE_NAME
echo "Finished backup up file $FILE_NAME"
