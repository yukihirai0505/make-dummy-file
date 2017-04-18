#!/bin/sh

function usage {
    cat <<EOF
$(basename ${0}) is a tool for make dummy image file.

Usage:
    sh ./$(basename ${0}) [<options>]

Options:
    -h, -height       set image height (default 200)
    -w, -width        set image width  (default 200)
    -s, -size         set image size   (default 1048218)
EOF
}

RED=31
GREEN=32
YELLOW=33
BLUE=34

function cecho {
    COLOR=$1
    shift
    echo "\033[${COLOR}m$@\033[m"
}

HEIGHT=200
WIDTH=200
SIZE=1048218

while getopts ":h:w:s:" OPT ; do
  case $OPT in
    # HEIGHT
    h)
      HEIGHT=$OPTARG
      ;;
    # WIDTH
    w)
      WIDTH=$OPTARG
      ;;
    # SIZE
    s)
      SIZE=$OPTARG
      ;;
    *)
      cecho $RED "[ERROR] Invalid subcommand '${1}'"
      usage
      exit 1
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
