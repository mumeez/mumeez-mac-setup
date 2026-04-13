#!/bin/bash

# Bandwidth item for SketchyBar
# Uses local bandwidth plugin

bandwidth=(
  update_freq=3
  label.font="$FONT:Regular:14.0"
  script="$PLUGIN_DIR/bandwidth.sh"
)

sketchybar --add item bandwidth left \
  --set bandwidth "${bandwidth[@]}"
