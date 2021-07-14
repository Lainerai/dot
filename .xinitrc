#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if test -f "$HOME/.Xresources"; then
    echo "merging ..."
    xrdb -merge "$HOME/.Xresources"
fi
# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

pidof -s xiddlehook >& /dev/null
if [ $? -ne 0 ]; then
    xidlehook \
  `# Don't lock when there's a fullscreen application` \
  --not-when-fullscreen \
  `# Don't lock when there's audio playing` \
  --not-when-audio \
  `# Dim the screen after 60 seconds, undim if user becomes active` \
  --timer 120 \
    'brightnessctl -s; brightnessctl set 100' \
    'brightnessctl -r' \
  `# Undim & lock after 10 more seconds` \
  --timer 5 \
    'brightnessctl -r; betterlockscreen -l --text "Please type the password ><"' \
    '' \
  `# Finally, suspend an hour after it locks` \
  --timer 3600 \
    'systemctl suspend' \
    '' &
fi


systemctl --user import-environment DISPLAY
###########################
###########################

xset r rate 280 70 
xsetroot -cursor_name left_ptr
exec bspwm
