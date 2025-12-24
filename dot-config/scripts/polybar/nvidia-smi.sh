#!/bin/sh
PER=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | awk '{ print ""$1"%"}')
if [[ "$(supergfxctl -g)" != "Integrated" ]]; then
  echo "$PER"
fi
