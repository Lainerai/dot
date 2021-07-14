#!/usr/bin/env bash

# You can call this script like this:
# $ ./brightnessControl.sh up
# $ ./brightnessControl.sh down

# Script inspired by these wonderful people:
# https://github.com/dastorm/volume-notification-dunst/blob/master/volume.sh
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

case $1 in
  up)
    # increase the backlight by 5%
    brightnessctl set 5%+
    dunstify "Brightness: " -h int:value:"`light | cut -d '.' -f 1`"
    ;;
  down)
    # decrease the backlight by 5%
    brightnessctl set 5%-
    dunstify "Brightness: " -h int:value:"`light | cut -d '.' -f 1`"
    ;;
esac
