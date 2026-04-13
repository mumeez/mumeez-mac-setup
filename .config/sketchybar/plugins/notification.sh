#!/bin/bash

source "$CONFIG_DIR/colors.sh"

# Check for GitHub notifications
if which gh >/dev/null 2>&1; then
  NOTIF_COUNT=$(gh api notifications --jq '.[] | select(.unread == true) | .id' 2>/dev/null | wc -l | tr -d ' ')
  
  if [ "$NOTIF_COUNT" -gt 0 ]; then
    sketchybar -m --set notification label="$NOTIF_COUNT" icon="🔔" icon.color=$GREEN label.color=$GREEN icon.drawing=on
  else
    sketchybar -m --set notification label="" icon.drawing=off
  fi
else
  sketchybar -m --set notification label="" icon.drawing=off
fi