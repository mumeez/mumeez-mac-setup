#!/bin/bash

# Filename: ~/github/dotfiles-latest/sketchybar/felixkratz/items/volume.sh

source "$CONFIG_DIR/icons.sh"

volume=(
  script="$PLUGIN_DIR/volume.sh"
  icon.font="$FONT:Regular:18.0"
  icon.color=$MAGENTA
  label.font="$FONT:Bold:16.0"
  label.color=$MAGENTA
  padding_right=3
  updates=on
)

CONNECTED_OUTPUT=$(SwitchAudioSource -t output -c 2>/dev/null)
if [[ "$CONNECTED_OUTPUT" == *"AirPods"* ]]; then
  volume+=("icon=$AIRPODS")
elif [[ "$CONNECTED_OUTPUT" == *"External"* ]]; then
  volume+=("icon=$HEADPHONES")
else
  volume+=("icon=$VOLUME_100")
fi

sketchybar --add item volume right \
  --set volume "${volume[@]}" \
  --subscribe volume volume_change
