#!/bin/sh
# Use the current timestamp as the unique filename of the screenshot.
FILE_PATH="/home/$USER/Pictures/Screenshots/ss_$(date -u +'%Y%m%d-%H%M%S').png"
TMP_FILE_PATH="/var/tmp/ss_$(date -u +'%Y%m%d-%H%M%S').png"

main() {
  case $1 in
  full) grim $TMP_FILE_PATH ;;
  select) grim -g "$(slurp)" $TMP_FILE_PATH ;;
  window) grimblast save active $TMP_FILE_PATH ;;
  screen) grim -o "$(hyprctl monitors -j | jq -r '.[0].name')" $TMP_FILE_PATH ;;
  esac
}

main "$@"

wl-copy <$TMP_FILE_PATH
notify-send "Screenshot saved" "\nClipboard and Directory." --app-name="Grim" -i $TMP_FILE_PATH
mv $TMP_FILE_PATH $FILE_PATH
