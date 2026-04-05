#!/bin/bash

# Configuration
NOTIF_ID=9910                  # Static ID so notifications replace each other
ICON_PATH="/tmp/mpris_art.png" # Temporary location for album art

# Define browsers to ignore (comma-separated)
# Common identifiers: firefox, chromium, brave, google-chrome
IGNORE_PLAYERS="firefox"

# Listen for metadata changes
# 1. Added --ignore-player flag
# 2. Added {{playerName}} to the end of the format string
playerctl metadata --follow --ignore-player="firefox" --format \
  "{{title}}|{{artist}}|{{album}}|{{mpris:artUrl}}|{{playerName}}" | while IFS="|" read -r title artist album art_url player_raw; do

  # Skip if title is empty (prevents errors on player close)
  [[ -z "$title" ]] && continue

  # Handle Album Art
  if [[ "$art_url" == file://* ]]; then
    # Local file: strip the prefix
    cp "${art_url#file://}" "$ICON_PATH"
    ICON_ARG="-i $ICON_PATH"
  elif [[ "$art_url" == http* ]]; then
    # Remote URL: download it
    curl -s "$art_url" -o "$ICON_PATH"
    ICON_ARG="-i $ICON_PATH"
  else
    # No art: use a generic music icon
    ICON_ARG="-i audio-x-generic"
  fi

  # Format the Player Name:
  # Capitalize the first letter (e.g., 'spotify' becomes 'Spotify')
  PLAYER_NAME=$(echo "$player_raw" | sed 's/./\U&/')

  # Send the notification
  # -a: now uses the dynamic $PLAYER_NAME
  dunstify -r "$NOTIF_ID" $ICON_ARG -a "$PLAYER_NAME" \
    "$title" \
    "$artist\n$album"

done
