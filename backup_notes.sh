#!/bin/bash

# Only Mac OS
uname -s | grep -q ^Darwin || (echo OS not supported; exit 1)

# No root
whoami | grep -q ^root$ && (echo use this from your user; exit 1)

BACKUP_DRIVE='/Volumes/home$'

SCRIPT_LOCATION=$(greadlink -f "$0")
SCRIPT_NAME=$0

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
/usr/local/bin/gtimeout 180 /usr/local/bin/rsync -rltvz --progress --delete-after "${HOME}/Library/Group Containers/group.com.apple.notes" "${HOME}/Library/Containers/com.apple.Notes" ${BACKUP_DRIVE}/ 2>&1 | /usr/bin/tee -a /tmp/rsync_notes.log
