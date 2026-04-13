#!/bin/bash

# Remove brackets as requested
sketchybar --remove cpu_bracket 2>/dev/null
sketchybar --remove system_bracket 2>/dev/null

# Reset system items to their original colors
sketchybar --set wifi icon.color=$GREEN label.color=$GREEN icon.padding_left=1 label.padding_right=1
sketchybar --set battery icon.color=$GREEN label.color=$GREEN icon.padding_left=1 label.padding_right=1
sketchybar --set brightness icon.color=$CREAMSICLE label.color=$CREAMSICLE icon.padding_left=1 label.padding_right=1
sketchybar --set volume icon.color=$MAGENTA label.color=$MAGENTA icon.padding_left=1 label.padding_right=1

# Reset CPU items to dynamic load colors
sketchybar --set cpu.percent \
           label.color=$LABEL_COLOR \
           label.padding_left=1 \
           label.padding_right=5

sketchybar --set cpu.sys \
           graph.color=$GREEN \
           graph.fill_color=$GREEN

sketchybar --set cpu.user \
           graph.color=$GREEN \
           graph.fill_color=$GREEN
