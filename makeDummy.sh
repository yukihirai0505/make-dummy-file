#!/bin/sh
wget http://lorempixel.com/200/200/ -O dummy.jpeg
cat /dev/urandom | LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w 1048218 | head -n 1 > dummy.txt
exiftool dummy.jpeg -comment\<=dummy.txt
rm dummy.jpeg_original
rm dummy.txt
