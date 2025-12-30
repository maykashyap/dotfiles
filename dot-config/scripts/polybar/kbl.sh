#!/bin/bash
# Keyboard layout

LANG=("de" "us")
CURRENT="$(setxkbmap -query | grep layout | awk '{ print $2 }')"
ICON=󰧺
IT=0
while [[ $IT -ne ${#LANG[@]} ]]; do
  if [[ "$CURRENT" = "${LANG[$IT]}" ]]; then
    break
  fi
  let IT++
done
if [[ "$1" = "--switch" ]]; then
  if [[ $IT -eq $((${#LANG[@]} - 1)) ]]; then
    ((IT = 0))
  else
    ((IT++))
  fi
  setxkbmap ${LANG[$IT]}
else
  echo "$ICON ${CURRENT^^}"
fi
