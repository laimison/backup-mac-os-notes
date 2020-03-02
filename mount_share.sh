#!/bin/bash

# Locations
SCRIPT_LOCATION=$(/usr/local/bin/greadlink -f "$0")
DIR_NAME=`dirname $SCRIPT_LOCATION`
SCRIPT_NAME=$0

# You need to create .env file with content: SHARE_ADDRESS=smb://user@server/directory
source $DIR_NAME/.env

echo $SHARE_ADDRESS

# Two methods to ensure this is mounted successfully
/usr/bin/osascript -e 'mount volume "'$SHARE_ADDRESS'"' || /usr/bin/open /Volumes && /usr/bin/open "$SHARE_ADDRESS"

sleep 5 && df -m
