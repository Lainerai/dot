#!/bin/bash




#####  set variables below ####

location_dir=$HOME/Videos/

T="$(date +%d-%m-%Y-%H-%M-%S)".mkv

#echo $T

video_window_title="$T"

#echo $video_window_title




####  Place video camera on own screen & detach the process  ####
ffplay -window_title "$video_window_title" /dev/video0 &




####  Record everything on the screen  ####
ffmpeg -y -f x11grab -s \
`xdpyinfo | grep 'dimensions:'|awk '{print $2}'` \
-i :0.0 -f alsa \
-i default $location_dir/$T

