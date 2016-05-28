#!/bin/bash

echo -n "Retriving the location of working directory... "
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Done"

echo -n "Cheking whether the working directory is valid... "
! [ "$DIR" == "/var/mobile/Library/AutoTouch/Scripts/www" ] &&\
echo "Invalid working directory!" &&\
echo "Working directory must be located in /var/mobile/Library/AutoTouch/Scripts/www" &&\
echo "Terminate the script" &&\
exit 0;
echo "Done"

if [[ "$(uname -m)" == iPad2,* ]]; then
    echo -n "Removing outdated images... "
    rm -rf $DIR/images
    echo "Done"

    echo -n "Copying latest images... "
    cp -r $DIR/../images $DIR
    echo "Done"

    echo -n "Rotating all images... "
    mogrify -rotate 270 $DIR/images/*.bmp
    echo "Done"
else
    ln -s $DIR/../images $DIR/images
fi