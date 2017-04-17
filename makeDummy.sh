#!/bin/sh

echo args=$@

HEIGHT=200
WIDTH=200

while getopts ":h:w:" OPT ; do
  case $OPT in
    # HEIGHT
    h)
      echo $OPT
      echo $OPTARG
      HEIGHT=$OPTARG
      ;;
    # WIDTH
    w)
      echo $OPT
      echo $OPTARG
      WIDTH=$OPTARG
      ;;
   esac
done

# Download image from lorempixel
wget http://lorempixel.com/${HEIGHT}/${WIDTH}/ -O dummy.jpeg

# Make dummy text
cat /dev/urandom | LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w 1048218 | head -n 1 > dummy.txt

# Insert comment to image
exiftool dummy.jpeg -comment\<=dummy.txt

# Remove temporary files
rm dummy.jpeg_original
rm dummy.txt
