#!/bin/bash

# Function to get brightness as a percentage
get_brightness() {
    # Extract specifically from the "brightness" dict inside "IODisplayParameters"
    # Format is: "brightness"={"min"=0,"max"=65536,"value"=32768}
    INFO=$(ioreg -n AppleARMBacklight -r)
    
    # Use awk to find the line with "brightness" and extract max and value
    # We target the one inside the dictionary
    VALS=$(echo "$INFO" | grep -o '"brightness"={[^{}]*}' | head -n 1)
    
    if [ -n "$VALS" ]; then
        CURR=$(echo "$VALS" | awk -F'="?' '{print $4}' | awk -F'"?,' '{print $1}' | tr -d '}')
        MAX=$(echo "$VALS" | awk -F'="?' '{print $3}' | awk -F'"?,' '{print $1}' | tr -d '}')
        
        if [ -n "$CURR" ] && [ -n "$MAX" ] && [ "$MAX" -gt 0 ]; then
            echo $(( CURR * 100 / MAX ))
            return 0
        fi
    fi

    # Fallback to rawBrightness if the above fails
    VALS=$(echo "$INFO" | grep -o '"rawBrightness"={[^{}]*}' | head -n 1)
    if [ -n "$VALS" ]; then
        CURR=$(echo "$VALS" | awk -F'="?' '{print $4}' | awk -F'"?,' '{print $1}' | tr -d '}')
        MAX=$(echo "$VALS" | awk -F'="?' '{print $3}' | awk -F'"?,' '{print $1}' | tr -d '}')
        
        if [ -n "$CURR" ] && [ -n "$MAX" ] && [ "$MAX" -gt 0 ]; then
            echo $(( CURR * 100 / MAX ))
            return 0
        fi
    fi

    echo 50
}

update() {
  PERCENT=$(get_brightness)
  [ -z "$PERCENT" ] && PERCENT=50
  sketchybar --set brightness label="${PERCENT}%"
}

case "$SENDER" in
"mouse.clicked" | "brightness_change")
  update
  ;;
*)
  update
  ;;
esac
