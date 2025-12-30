#!/bin/bash
asusctl profile -n

dunstify -h string:x-dunst-stack-tag:asus_profile "AsusCTL" "Current Profile: $(asusctl profile -p | grep Active | awk '{print $NF}')" -a "ASUS"
