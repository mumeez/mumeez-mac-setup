#!/bin/bash

# Filename: ~/github/dotfiles-latest/sketchybar/felixkratz-linkarzu/plugins/mic_click.sh
# ~/github/dotfiles-latest/sketchybar/felixkratz-linkarzu/plugins/mic_click.sh

# https://github.com/FelixKratz/SketchyBar/discussions/12#discussioncomment-1216899

source "$CONFIG_DIR/colors.sh"

# This is basically the same as the `toggle_devices()` function in:
# ~/github/dotfiles-latest/sketchybar/felixkratz/plugins/volume_click.sh
toggle_mics() {
  which SwitchAudioSource >/dev/null || exit 0
  source "$CONFIG_DIR/colors.sh"

  args=(--remove '/mic.device\.*/' --set "$NAME" popup.drawing=toggle)
  COUNTER=0
  CURRENT="$(SwitchAudioSource -t input -c)"
  while IFS= read -r device; do
    COLOR=$GREY
    if [ "${device}" = "$CURRENT" ]; then
      COLOR=$GREEN
    fi
    args+=(--add item mic.device.$COUNTER popup."$NAME"
      --set mic.device.$COUNTER label="${device}"
      label.color="$COLOR"
      click_script="SwitchAudioSource -t input -s \"${device}\" && sketchybar --set /mic.device\.*/ label.color=$GREY --set \$NAME label.color=$GREEN --set $NAME popup.drawing=off")
    COUNTER=$((COUNTER + 1))
  done <<<"$(SwitchAudioSource -a -t input)"

  sketchybar -m "${args[@]}" >/dev/null
}

# Toggle mic mute/unmute on left click
MIC_VOLUME=$(osascript -e 'input volume of (get volume settings)')
if [ "$MIC_VOLUME" -gt 0 ]; then
  osascript -e 'set volume input volume 0'
  sketchybar -m --set mic label="Muted" icon="🔇" icon.color=$RED label.color=$RED
else
  osascript -e 'set volume input volume 72'
  sketchybar -m --set mic label="50%" icon="🎤" icon.color=$GREEN label.color=$GREEN
fi
