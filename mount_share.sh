#!/bin/bash

# You need to create .env file with content: SHARE_ADDRESS=smb://user@server/directory
source .env

# Two methods to ensure this is mounted successfully
/usr/bin/osascript -e 'mount volume "'$SHARE_ADDRESS'"' || /usr/bin/open /Volumes && /usr/bin/open "$SHARE_ADDRESS"

sleep 5 && df -m
