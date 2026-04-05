#!/bin/bash
#   script.sh lock
#   script.sh logout

action="$1"

detect_session() {
  # Check XDG_SESSION_DESKTOP or XDG_CURRENT_DESKTOP first
  if [[ -n "$XDG_SESSION_DESKTOP" ]]; then
    echo "$XDG_SESSION_DESKTOP" | tr '[:upper:]' '[:lower:]'
    return
  fi

  if [[ -n "$XDG_CURRENT_DESKTOP" ]]; then
    echo "$XDG_CURRENT_DESKTOP" | tr '[:upper:]' '[:lower:]'
    return
  fi

  # Fallback: check running processes
  if pgrep -x sway >/dev/null; then
    echo "sway"
  elif pgrep -x i3 >/dev/null; then
    echo "i3"
  elif pgrep -x Hyprland >/dev/null; then
    echo "hyprland"
  else
    echo "unknown"
  fi
}

session=$(detect_session)

case "$session" in
sway)
  if [[ "$action" == "lock" ]]; then
    swaylock
  elif [[ "$action" == "logout" ]]; then
    swaymsg exit
  fi
  ;;
i3)
  if [[ "$action" == "lock" ]]; then
    eval "~/.config/i3/i3lock.sh"
  elif [[ "$action" == "logout" ]]; then
    i3-msg exit
  fi
  ;;
hyprland)
  if [[ "$action" == "lock" ]]; then
    # hyprlock if installed
    if command -v hyprlock >/dev/null; then
      hyprlock
    else
      echo "hyprlock not installed"
      exit 1
    fi
  elif [[ "$action" == "logout" ]]; then
    hyprctl dispatch exit
  fi
  ;;
*)
  echo "Unsupported or unknown DE/WM: $session"
  exit 1
  ;;
esac
