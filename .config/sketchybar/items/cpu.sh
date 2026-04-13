#!/bin/bash

# Define the font if not already available
FONT="JetBrainsMono Nerd Font"

# Helper process name
HELPER=git.felix.helper

cpu_percent=(
  label.font="$FONT:Bold:16.0"
  label.color=$LABEL_COLOR
  padding_right=5
  width=45
  icon.drawing=off
  update_freq=5
  mach_helper="$HELPER"
)

cpu_sys=(
  width=0
  graph.color=0xff76cce0
  graph.fill_color=0xff76cce0
  label.drawing=off
  icon.drawing=off
  background.height=30
  background.drawing=on
  background.color=$TRANSPARENT
)

cpu_user=(
  graph.color=0xff76cce0
  graph.fill_color=0xff76cce0
  label.drawing=off
  icon.drawing=off
  background.height=30
  background.drawing=on
  background.color=$TRANSPARENT
)

sketchybar --add item cpu.percent right          \
           --set cpu.percent "${cpu_percent[@]}" \
                                                 \
           --add graph cpu.sys right 75          \
           --set cpu.sys "${cpu_sys[@]}"         \
                                                 \
           --add graph cpu.user right 75         \
           --set cpu.user "${cpu_user[@]}"

# Helper handles the label.color based on load
# Default graph is BLUE from workspaces as requested
