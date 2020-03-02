#!/bin/bash

# Only Mac OS
uname -s | grep -q ^Darwin || (echo OS not supported; exit 1)

# No root
whoami | grep -q ^root$ && (echo use this from your user; exit 1)

# Locations
SCRIPT_LOCATION=$(/usr/local/bin/greadlink -f "$0")
DIR_NAME=`dirname $SCRIPT_LOCATION`
SCRIPT_NAME=$0

# You need to create .env file with content: MOUNTED_TO='/Volumes/folder_name'
source $DIR_NAME/.env

echo $MOUNTED_TO

# Install rsync 3 if not installed
ls /usr/local/bin/rsync > /dev/null|| brew install rsync

# Add me to crontab
crontab -l > /tmp/my_cron
if ! grep -q "$SCRIPT_NAME" /tmp/my_cron
then
  echo "*/5 * * * * $SCRIPT_LOCATION" >> /tmp/my_cron
  crontab /tmp/my_cron && /bin/rm -f /tmp/my_cron
fi

# Do backup
# If you have permissions issue because user or group is different on external share use -rltvz, otherwise -vaE 
/usr/local/bin/gtimeout 180 /usr/local/bin/rsync -rltvz --progress --delete-after "${HOME}/Library/Group Containers/group.com.apple.notes" "${HOME}/Library/Containers/com.apple.Notes" ${MOUNTED_TO}/ 2>&1 | /usr/bin/tee -a /Users/${USER}/Downloads/backup_notes.log
if [ "$?" == "0" ]; then echo backup completed successfully; else backup failed; fi | /usr/bin/tee -a /Users/${USER}/Downloads/backup_notes.log
