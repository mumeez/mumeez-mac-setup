#!/bin/bash

# Click to increase brightness
BRIGHTNESS=$(brightness 2>/dev/null)
NEW_BRIGHTNESS=$(echo "$BRIGHTNESS + 0.1" | bc 2>/dev/null | cut -d. -f1)

[ -z "$NEW_BRIGHTNESS" ] && NEW_BRIGHTNESS=1
[ "$NEW_BRIGHTNESS" -gt 100 ] && NEW_BRIGHTNESS=1
[ "$NEW_BRIGHTNESS" -lt 1 ] && NEW_BRIGHTNESS=0.1

brightness "$NEW_BRIGHTNESS" 2>/dev/null