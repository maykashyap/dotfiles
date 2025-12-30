#!/bin/bash

# 1. Set the directory you want to browse
TARGET_DIR="$HOME/Desktop/"

# 2. Use find to list files/folders (maxdepth 1 keeps it to the current folder)
# We use sed to remove the leading './' for a cleaner look in rofi
selection=$(find "$TARGET_DIR" -maxdepth 1 -mindepth 1 -printf "%f\n" | sort)

# 3. If the user didn't cancel (hit ESC), open the selection
if [ -n "$selection" ]; then
  xdg-open "$TARGET_DIR/$selection"
fi
