#!/bin/bash

# Network Bandwidth plugin for SketchyBar
# Monitors local interface en0 (Standard for Mac)

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

INTERFACE=en0
INFO=$(netstat -i -I $INTERFACE -b | tail -n 1)
IN=$(echo $INFO | awk '{print $7}')
OUT=$(echo $INFO | awk '{print $10}')

# Store previous values to calculate rate
# Using a temp file for simplicity
PREV_FILE="/tmp/sketchybar_bandwidth"
if [ ! -f $PREV_FILE ]; then
  echo "$IN $OUT" > $PREV_FILE
  sketchybar --set $NAME label="0B/s  0B/s "
  exit 0
fi

PREV_DATA=$(cat $PREV_FILE)
PREV_IN=$(echo $PREV_DATA | awk '{print $1}')
PREV_OUT=$(echo $PREV_DATA | awk '{print $2}')
echo "$IN $OUT" > $PREV_FILE

DIFF_IN=$((IN - PREV_IN))
DIFF_OUT=$((OUT - PREV_OUT))

# Convert to human readable (approx per second based on update frequency)
human_readable() {
  local bytes=$1
  if [ $bytes -gt 1048576 ]; then
    echo "$(echo "scale=1; $bytes/1048576" | bc)MB/s"
  elif [ $bytes -gt 1024 ]; then
    echo "$(echo "$bytes/1024" | bc)KB/s"
  else
    echo "${bytes}B/s"
  fi
}

IN_HR=$(human_readable $DIFF_IN)
OUT_HR=$(human_readable $DIFF_OUT)

sketchybar --set $NAME label="${IN_HR}  ${OUT_HR} "
