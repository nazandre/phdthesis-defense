# inspired by http://abarry.org/the-new-complete-guide-to-embedded-videos-in-beamer-under-linux/

#! /bin/bash

video="$1"

if [ ! -e $1 ] 
then
    echo "error: $1 does not exist!"
    exit
fi

name=${video%.*}

avconv -i $video -vframes 1 -an -f image2 -y $name.jpg
