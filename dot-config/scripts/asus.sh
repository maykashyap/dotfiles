#!/bin/bash
asusctl profile next

dunstify -h string:x-dunst-stack-tag:asus_profile "AsusCTL" \
  "Current Profile: $(asusctl profile get | grep Active | awk '{print $NF}')" -a "ASUS"
