#!/bin/bash

notification=(
  updates=on
  label.drawing=on
  padding_right=5
  label.font="$FONT:Regular:14.0"
  icon.font="$FONT:Regular:14.0"
  icon.color=$GREEN
  script="$PLUGIN_DIR/notification.sh"
)

sketchybar --add item notification right \
  --set notification "${notification[@]}"
