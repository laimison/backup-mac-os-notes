# backup-mac-os-notes

This is the script to make backups of app called "Notes" on a Mac

## Prerequisites

### Install Dependencies

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install coreutils
```

### Make sure you have rsync 3

```
brew install rsync
rsync --version
```

## Check logs

```
less /Users/${USER}/Downloads/backup_notes.log
```

## Recover the notes

```
open ~/Library/Group\ Containers
mv group.com.apple.notes group.com.apple.notes.original.one
mkdir group.com.apple.notes
```

copy all files into `group.com.apple.notes`

