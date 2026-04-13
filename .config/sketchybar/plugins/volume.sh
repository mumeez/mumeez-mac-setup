#!/bin/bash

# Filename: ~/github/dotfiles-latest/sketchybar/felixkratz/plugins/volume.sh

source "$CONFIG_DIR/icons.sh"

volume_change() {
  case $INFO in
  [6-9][0-9] | 100)
    ICON=$VOLUME_100
    ;;
  [3-5][0-9])
    ICON=$VOLUME_66
    ;;
  [1-2][0-9])
    ICON=$VOLUME_33
    ;;
  [1-9])
    ICON=$VOLUME_10
    ;;
  0)
    ICON=$VOLUME_0
    ;;
  *) ICON=$VOLUME_100 ;;
  esac

  # Override icon if AirPods are currently the default output
  CONNECTED_OUTPUT=$(SwitchAudioSource -t output -c)
  if [[ "$CONNECTED_OUTPUT" == *"AirPods"* ]]; then
    ICON=$AIRPODS
  elif [[ "$CONNECTED_OUTPUT" == *"External"* ]]; then
    ICON=$HEADPHONES
  fi

  sketchybar --set volume icon=$ICON label="${INFO}%"
}

case "$SENDER" in
"volume_change")
  volume_change
  ;;
esac
