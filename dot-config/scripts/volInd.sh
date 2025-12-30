#!/bin/bash
case $1 in
"-i")
  pamixer --increase 2
  ;;
"-d")
  pamixer --decrease 2
  ;;
esac
VOL="$(pamixer --get-volume)"
ICON="$(~/.config/scripts/polybar/pipewire.sh | awk '{print $1}')"
dunstify -a "user-config" -h string:x-canonical-private-synchronous:audio "$ICON" "<i>Volume:</i> <b>$VOL%</b>" -h int:value:"$VOL"
