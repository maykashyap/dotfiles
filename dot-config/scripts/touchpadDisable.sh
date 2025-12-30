#!/bin/bash
DEVICE_ID="$(xinput list | grep -Po 'Touchpad.*id=\K\d+')"
ENABLED="$(xinput list-props $DEVICE_ID | grep -Po 'Enabled.*:.*\K\d+')"
xinput set-prop $DEVICE_ID "Device Enabled" $((1 - $ENABLED))
ICONS=("󱊨 " "󰌌 ")
DESC=("enabled" "disabled")
dunstify -h string:x-dunst-stack-tag:tp_toggle "${ICONS[$ENABLED]}" "Touchpad ${DESC[$ENABLED]}" -a "user-config"
