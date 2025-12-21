#!/bin/bash
asusctl profile -n

notify-send "AsusCTL" "Current Profile: $(asusctl profile -p | grep Active | awk '{print $NF}')" --app-name="ASUS"
