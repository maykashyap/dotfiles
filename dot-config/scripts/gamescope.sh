#!/bin/bash
export STEAM_MULTIPLE_XWAYLANDS=1
export DXVK_HDR=1
export ENABLE_HDR_WSI=1
gamescope -f -e -w 2560 -h 1440 -r 144 -O DP-1 --xwayland-count 2 \
  --hdr-enabled --hdr-itm-enabled \
  --mangoapp \
  -- steam -gamepadui -steamos3
