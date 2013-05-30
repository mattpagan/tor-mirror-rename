#!/bin/bash
# tor-mirror-rename.sh

## This script is for anyone who wants to run an unlisted torproject.org
## mirror. This will replace the names of some website subdirectories, 
## which may make the mirror harder to block. 

## This script should be added to a cron job like so:
## 0 */6 * * * tor-mirror-rename.sh

ARGS="-aq --delete"
SITE="rsync://rsync.torproject.org/website-mirror"
LOCATION="/var/www/"
NEWDIST="d1st"
NEWTORBROWSER="t0rbr0wser"

rsync $ARGS $SITE $LOCATION
mv $LOCATION/dist/torbrowser $LOCATION/dist/$NEWTORBROWSER
mv $LOCATION/dist $LOCATION/$NEWDIST
## all files of the form foo/dist/torbrowser/bar are 
## now known as foo/$NEWDIST/$NEWTORBROWSER/bar

replace_strings () {
  sed "s/dist\/torbrowser/$NEWDIST\/$NEWTORBROWSER/g" $dir > $dir.new
    ## Makes a new file with the newly named file paths
  rm $dir ## This is the html file without file paths replaced
  mv $dir.new $dir ## Now it's back
}

walk () {
for dir in `echo *`
do
   if [ -d "$dir" ] ; then # If it is a directory
     cd $dir               # enter the directory
     walk()                # and execute this script recursively
     cd ..                 # then leave the directory
   else                    # Not a directory
     replace_strings()
   fi
done
}
 
walk()

exit 0
