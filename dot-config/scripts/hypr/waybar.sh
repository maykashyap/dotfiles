#!/bin/bash

# Use pidof to find the actual Waybar binary process
WAYBAR_PID=$(pidof waybar)

launch_waybar() {
  # If waybar is running, kill it
  if [ ! -z "$WAYBAR_PID" ]; then
    killall waybar
    # Wait until it's actually dead
    while pidof waybar >/dev/null; do sleep 0.1; done
  fi
  waybar &
}

case "$1" in
--init)
  launch_waybar
  ;;
*)
  if [ -z "$WAYBAR_PID" ]; then
    waybar &
    hyprctl keyword general:gaps_in 4
    hyprctl keyword general:gaps_out 4
    hyprctl keyword decoration:rounding 10
    hyprctl keyword decoration:rounding_power 10
  else
    killall waybar
    hyprctl keyword general:gaps_in 1
    hyprctl keyword general:gaps_out 0
    hyprctl keyword decoration:rounding 0
    hyprctl keyword decoration:rounding_power 0
  fi
  ;;
esac
