#!/bin/bash

notify() {
  dunstify -h string:x-dunst-stack-tag:power "Power mode" $1 -a "sys"
}

optimize_hyprland() {
  local animations=$1
  local blur=$2
  local monitor_mode=$3

  hyprctl keyword animations:enabled "$animations"
  hyprctl keyword decoration:blur:enabled "$blur"
  hyprctl keyword monitor "eDP-2,$monitor_mode,auto,1"
}

optimize_hardware() {
  local profile=$1
  local brightness=$2
  asusctl profile set $profile
  brightnessctl set $brightness
}

if [ "$1" = "bat" ]; then
  echo "Entering Powersave."
  notify "Battery"
  optimize_hyprland 0 0 "1920x1080@60"
  optimize_hardware "Quiet" "40%"
  if [ "$(supergfxctl -g)" != "Integrated" ]; then
    echo "Not in iGPU mode."
  fi
  hyprctl reload
elif [ "$1" = "ac" ]; then
  echo "Entering Performance."
  notify "AC"
  optimize_hyprland 1 1 "1920x1080@144"
  optimize_hardware "Performance" "100%"
  hyprctl reload
else
  echo "Invalid option."
  exit 1
fi
