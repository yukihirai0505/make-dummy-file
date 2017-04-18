#!/bin/sh

echo args=$@

HEIGHT=200
WIDTH=200
SIZE=1048218

while getopts ":h:w:s:" OPT ; do
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
    # SIZE
    s)
      echo $OPT
      echo $OPTARG
      SIZE=$OPTARG
      ;;
   esac
done

# Download image from placehold.jp
wget http://placehold.jp/${HEIGHT}x${WIDTH}.png -O dummy.png

# Make dummy text
cat /dev/urandom | LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w ${SIZE} | head -n 1 > dummy.txt

# Insert comment to image
exiftool dummy.png -comment\<=dummy.txt

# Remove temporary files
rm dummy.png_original
rm dummy.txt
