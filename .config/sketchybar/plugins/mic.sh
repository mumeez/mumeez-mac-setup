#!/bin/bash

# Simple Mic plugin for SketchyBar
MIC_VOLUME=$(osascript -e 'input volume of (get volume settings)')

if [ "$MIC_VOLUME" -eq 0 ]; then
  ICON=󰍭
  COLOR=$RED
else
  ICON=󰍬
  COLOR=$WHITE
fi

sketchybar --set $NAME icon=$ICON label="$MIC_VOLUME%" icon.color=$COLOR
