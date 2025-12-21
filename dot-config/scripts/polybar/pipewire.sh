#!/bin/sh

getDefaultSink() {
  defaultSink=$(pactl info | awk -F : '/Default Sink:/{print $2}')
  description=$(pactl list sinks | sed -n "/${defaultSink}/,/Description/s/^\s*Description: \(.*\)/\1/p")
  echo "${description}"
}

getDefaultSource() {
  defaultSource=$(pactl info | awk -F : '/Default Source:/{print $2}')
  description=$(pactl list sources | sed -n "/${defaultSource}/,/Description/s/^\s*Description: \(.*\)/\1/p")
  echo "${description}"
}

VOLUME=$(pamixer --get-volume-human)
SINK=$(getDefaultSink)
SOURCE=$(getDefaultSource)
ICON="󰕾"
if [[ "$(pactl info | awk -F : '/Default Sink:/{print $2}')" =~ "bluez" ]]; then
  ICON="󱡒"
fi
case $1 in
"--up")
  pamixer --increase 1
  ;;
"--down")
  pamixer --decrease 1
  ;;
"--mute")
  pamixer --toggle-mute
  ;;
*)
  echo "$ICON ${VOLUME}"
  ;;
esac
