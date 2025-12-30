#!/bin/sh

# Use the current timestamp as the unique filename of the screenshot.
FILE_PATH="/home/$USER/Pictures/Screenshots/ss_$(date -u +'%Y%m%d-%H%M%S').png"
TMP_FILE_PATH="/var/tmp/ss_$(date -u +'%Y%m%d-%H%M%S').png"
main() {
  case $1 in
  full) maim --format=png $TMP_FILE_PATH ;;
  select) maim --select $TMP_FILE_PATH ;;
  window) maim --window $(xdotool getactivewindow) $TMP_FILE_PATH ;;
  screen) maim -x :0.0 $TMP_FILE_PATH ;;
  esac
}
main "$@"
cat $TMP_FILE_PATH | xclip -selection clipboard -target image/png -i
notify-send "Screenshot saved" "\nClipboard and Directory." --app-name="Maim" -i $TMP_FILE_PATH
mv $TMP_FILE_PATH $FILE_PATH
