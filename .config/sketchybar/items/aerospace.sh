#!/bin/bash

# Define workspace icons (reduced to 1-4)
SPACE_ICONS=("1" "2" "3" "4")

# Add spaces to the bar
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))
  sketchybar --add item space.$sid left \
             --set space.$sid \
             icon="${SPACE_ICONS[i]}" \
             icon.padding_left=8 \
             icon.padding_right=8 \
             label.drawing=off \
             background.corner_radius=5 \
             background.height=26 \
             background.drawing=on \
             background.color=0x00000000 \
             script="$PLUGIN_DIR/aerospace.sh $sid" \
             click_script="aerospace workspace $sid" \
             --subscribe space.$sid aerospace_workspace_change
done
