#!/bin/bash

# Calendar/Clock item for SketchyBar
calendar=(
  padding_left=15
  update_freq=30
  label.font="$FONT:Bold:16.0"
  label.align=right
  label.color=$RED
  icon.drawing=off
  icon.color=0xff1e1e2e
  background.drawing=off
  script="$PLUGIN_DIR/calendar.sh"
  click_script="sketchybar --set \$NAME popup.drawing=toggle"
)

sketchybar --add item calendar right \
  --set calendar "${calendar[@]}"
