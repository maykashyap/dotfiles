#!/bin/bash

GPU_MODE="$(supergfxctl -g)"
POWER_MODE="$(asusctl profile get | grep Active | awk '{print $NF}')"

declare -A GPU
GPU["AsusMuxDgpu"]="󰇋"
GPU["Hybrid"]="󱅋"
GPU["Integrated"]="󱅊"

declare -A POWER
POWER["Quiet"]="󰛓"
POWER["LowPower"]="󰛓"
POWER["Balanced"]="󰗑"
POWER["Performance"]="󰈸"

echo "${GPU[$GPU_MODE]} + ${POWER[$POWER_MODE]}"

if [ "$1" == "next" ]; then
  asusctl profile next 2>&1 >>/dev/null
  # dunstify -h string:x-dunst-stack-tag:asus_profile "AsusCTL" "Current Profile: $(asusctl profile -p | grep Active | awk '{print $NF}')" -a "ASUS"
fi
