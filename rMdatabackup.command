#!/bin/zsh
#
# Fast, incemental backup of reMarkable2 notebook data using rsync
#
# Intended for macOS: .command files can be double-clicked to run.
# zsh is macOS' standard shell.
#
# u/RedTartan04 13/01/2023
#

# Will look for rM device on two different ssh hostnames
# (e.g. Wifi and USB)
# (assignments must not have spaces around = sign...)
rMhostname="rm2"
rMhostname2="rm2usb"

# Do not enclose a path with ~ in "", otherwise the ~ is not expanded 
#  and rsync thinks this is a path relative to the current dir.
# (could be expanded here by pattern replacement:
#  "${localSyncDir/#~/$HOME}")
# Do not use a path with spaces in it... they had to be escaped.
localSyncDir=~/Documents/reMarkable/_backup/_rsync_backup

# is the rM online?
# (will timeout with exit code 2 if not)
echo "** searching for reMarkable..."
# wifi
ping -c 1 -t 5 $rMhostname
# not found
if (( ? != 0 )) then
  # try usb
  rMhostname=$rMhostname2
  echo "trying $rMhostname..."
  ping -c 1 -t 5 $rMhostname
fi

# evaluate exit code
if [ $? -eq 0 ]
then
  echo "** reMarkable was found"
  echo "** syncing $rMhostname to $localSyncDir"
  # add -n to only simulate transfer
  # keep deleted files in separate local directory:
  #rsync -rtb --backup-dir=deleted --delete --exclude=.DS_Store -v $rMhostname:/home/root/.local/share/remarkable/xochitl $localSyncDir
  # don't backup deleted files (e.g. when backing up to versioned location such as a git repo):
  rsync -rtb --delete --exclude=.DS_Store -v $rMhostname:/home/root/.local/share/remarkable/xochitl $localSyncDir
  exit $?
else
  echo "** reMarkable NOT FOUND in the local network" >&2
  exit 1
fi
