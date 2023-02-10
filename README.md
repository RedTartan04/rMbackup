# rMdatabackup

Fast, incemental backup of reMarkable2 notebook data using rsync, intended for macOS.

## Usage

The script has no command-line options. 

On a Mac it can be simply double-clicked to run, because it has the extension `.command`

Other platforms may require the extension `.sh` and maybe a `chmod u+x rMdatabackup.sh` to make it executable.

### Set rM device's ssh names and local backup folder paths

Required - change these in the script:

```
rMhostname=...
rMhostname2=...

localSyncDir=...
```
