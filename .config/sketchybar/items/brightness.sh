#!/bin/bash

source "$CONFIG_DIR/icons.sh"

brightness_item=(
  script="$PLUGIN_DIR/brightness.sh"
  icon=$BRIGHTNESS_ICON
  icon.color=$CREAMSICLE
  icon.font="$FONT:Regular:18.0"
  label.font="$FONT:Bold:16.0"
  label.color=$CREAMSICLE
  padding_right=3
  update_freq=2
  updates=on
  click_script="$PLUGIN_DIR/brightness_click.sh"
)

sketchybar --add item brightness right \
  --set brightness "${brightness_item[@]}" \
  --subscribe brightness mouse.clicked brightness_change
