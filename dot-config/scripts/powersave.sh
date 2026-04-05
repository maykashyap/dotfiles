#!/bin/bash
if [ $1 -eq 0 ] ; then
  xrandr --output eDP-2 --mode 1920x1080 --rate 144
fi
xrandr --output eDP-2 --mode 1920x1080 --rate 60
asusctl -k low
xbacklight -set 50
exit 0
