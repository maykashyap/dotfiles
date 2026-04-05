#!/bin/bash
PLAYER=$(playerctl -l)
song=$(playerctl metadata --format "{{ title }}")
songDesc = $(playerctl metadata --format "{{ artist }}\n{{ album }}")
dunstify -a "$PLAYER[1]" -h $song" "$songDesc"
