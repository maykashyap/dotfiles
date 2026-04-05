#!/bin/bash

# Get the lid state
LID_STATE=$(grep -oP "(?<=state:).*" /proc/acpi/button/lid/LID/state | xargs)

# Get the name of your displays (Check 'xrandr --query')
INTERNAL="DP-2"
EXTERNAL="DP-1"

if [ "$LID_STATE" = "closed" ]; then
  xrandr --output "$INTERNAL" --off --output "$EXTERNAL" --mode 2560x1440 --rate 165.01
else
  xrandr --output "$EXTERNAL" --mode 2560x1440 --rate 165.01 --pos 1920x0 --primary --output "$INTERNAL" --mode 1920x1080 --pos 0x0 --rate 144
fi

i3-msg reload
