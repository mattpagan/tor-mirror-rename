#!/bin/bash
ARGS="-aq --delete"
SITE="rsync://rsync.torproject.org/website-mirror"
LOCATION="/var/www/"

rsync $ARGS $SITE $LOCATION
mv $LOCATION/dist/t0rbr0wser
mv $LOCATION/dist $LOCATION/d1st
## all files of the form foo/dist/torbrowser/bar are 
## now known as foo/d1st/t0rbr0wser/bar

replace_strings () {
  sed 's/dist\/torbrowser/d1st\/t0rbr0wser/g' *.html.en > $dir.new
    ## Makes a new file with good file paths
  rm -f $dir ## This is the html file without file paths replaced
  mv $dir.new $dir ## Now it's back
}

walk () {
for dir in `echo *`
do
   if [ -d "$dir" ] ; then # ==> If it is a directory (-d)...
     cd $dir
     walk()
     cd ..
   else ## not a directory
     replace_strings()
   fi
done
}
 
walk()

exit 0;
