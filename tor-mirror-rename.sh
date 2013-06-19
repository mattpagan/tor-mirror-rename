#!/bin/bash
# tor-mirror-rename.sh

## This script is for anyone who wants to run an unlisted torproject.org
## mirror. This will replace the names of some website subdirectories, 
## which may make the mirror harder to block. 

## This script should be added to a cron job like so:
## 0 */6 * * * tor-mirror-rename.sh

ARGS="-aq --delete"
SITE="rsync://rsync.torproject.org/website-mirror"
LOCATION="/var/www/t0r"
NEWDIST="d1st"
NEWTORBROWSER="t0rbrowser"

rsync $ARGS $SITE $LOCATION

if [ ! -x $LOCATION/$NEWDIST ]
  do mkdir $LOCATION/$NEWDIST; done
fi
if [ ! -x $LOCATION/$NEWDIST/$NEWTORBROWSER ]
  do mkdir $LOCATION/$NEWDIST/$NEWTORBROWSER; done
fi
## Now we have a dist/torbrowser and a d1st/t0rbrowser directory

rsync $ARGS $LOCATION/dist $LOCATION/$NEWDIST
mv $LOCATION/$NEWDIST/torbrowser $LOCATION/$NEWDIST/$NEWTORBROWSER
## all files of the form foo/dist/torbrowser/bar are 
## now also known as foo/$NEWDIST/$NEWTORBROWSER/bar

exit 0;

