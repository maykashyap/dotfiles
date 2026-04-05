#!/bin/bash

kdeconnect-cli --refresh

DEVICE_NAME="$(kdeconnect-cli -a --name-only 2>/dev/null)"

# ── KDE Connect ───────────────────────────────────────────────
KDE_CONNECTED=false
[[ -n "$DEVICE_NAME" ]] && KDE_CONNECTED=true

# ── Bluetooth ─────────────────────────────────────────────────
BT_CONNECTED=false
while IFS= read -r line; do
  read -r _ _ name <<<"$line"
  [[ -n "$name" ]] && BT_CONNECTED=true && break
done < <(bluetoothctl devices Connected 2>/dev/null)

# ── Output ────────────────────────────────────────────────────
if $KDE_CONNECTED && $BT_CONNECTED; then
  echo "󰄡  + 󰋋"
elif $KDE_CONNECTED; then
  echo "󰄡  + 󰟎"
elif $BT_CONNECTED; then
  echo "󰄢  + 󰋋"
else
  echo "󰄢  + 󰟎"
fi
