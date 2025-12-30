#!/bin/bash

# Configuration
NOTIF_ID=9910                  # Static ID so notifications replace each other
ICON_PATH="/tmp/mpris_art.png" # Temporary location for album art

# Listen for metadata changes using playerctl
playerctl metadata --follow --format \
  "{{title}}|{{artist}}|{{album}}|{{mpris:artUrl}}" | while IFS="|" read -r title artist album art_url; do

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

  # Send the notification
  # -r: replaces the previous notification
  # -a: sets the app name
  dunstify -r "$NOTIF_ID" $ICON_ARG -a "Media Player" \
    "$title" \
    "$artist\n$album"

done
