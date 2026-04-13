#!/bin/bash

battery=(
	script="$PLUGIN_DIR/battery.sh"
	icon.font="$FONT:Regular:18.0"
	icon.color=$BLUE
	padding_right=3
	padding_left=0
	label.drawing=on
	label.color=$BLUE
	update_freq=120
	updates=on
	click_script="sketchybar --set \$NAME label.drawing=toggle"
)

sketchybar --add item battery right \
	--set battery "${battery[@]}" \
	--subscribe battery power_source_change system_woke
