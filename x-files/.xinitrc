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

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# randomize wallpaper - /usr/bin/rand-wallpaper
# exec rand-wallpaper & 
exec feh --bg-scale $HOME/Pictures/wallpaper/color-gradient.jpg &

# unclutter mouse
exec unclutter -grab &

# use basic compton config
exec compton -c --shadow-exclude-reg 1920x37+0-0 --config ~/.config/compton/compton.conf &

# init xmonad
exec xmonad

