#!/bin/bash

# $1 is the workspace number passed from the item script
# $FOCUSED_WORKSPACE is passed from the aerospace trigger

# If FOCUSED_WORKSPACE is empty (like during a reload), fetch it manually
if [ -z "$FOCUSED_WORKSPACE" ]; then
    FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
fi

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.drawing=on \
                         background.color=0xff76cce0 \
                         icon.color=0xff1e1e2e
else
    sketchybar --set $NAME background.drawing=on \
                         background.color=0x00000000 \
                         icon.color=0xff76cce0
fi
