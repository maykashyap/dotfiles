#!/bin/bash

# Configuration
STEP=5

# Helper to set internal brightness
set_brightness() {
  brightnessctl set "$1" -q
}

# Logic for Aliases/Keybinds
case $1 in
--up)
  set_brightness "${2:-$STEP}%+"
  ;;
--down)
  set_brightness "${2:-$STEP}%-"
  ;;
--set)
  set_brightness "$2%"
  ;;
esac
