#!/bin/bash
# Laptop only
EMONBL=-1
IMONBL=$(xbacklight -get | awk -F. '{print $1}')
STEP=5
if ddcutil detect | grep -q "Display"; then
  EMONBL=$(ddcutil getvcp 10 | awk -F'current value = *' '{print $2}' | awk -F',' '{print $1}')
fi
#increment and decrement is too slow
case $1 in
"--up")
  if [ $EMONBL -ne -1 ]; then
    ((EMONBL += STEP))
    ddcutil setvcp 10 $EMONBL
  fi
  xbacklight -inc $STEP
  ;;
"--down")
  if [ $EMONBL -ne -1 ]; then
    ((EMONBL -= STEP))
    ddcutil setvcp 10 $EMONBL
  fi
  xbacklight -dec $STEP
  ;;
*)
  if [ $EMONBL -eq -1 ]; then
    echo "󰖙 $IMONBL"
  fi
  echo "󰖙 ( 󰍹  $EMONBL + 󰌢  $IMONBL )"
  ;;
esac
