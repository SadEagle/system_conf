#!/bin/sh

CACHE_BRIGHTNESS=$HOME/.cache/ddc_backup 

for MONITOR in $(ddcutil detect | grep "Display" | awk '{print $2}'); do
    BRIGHTNESS_FILE=${CACHE_BRIGHTNESS}/brightness_$MONITOR

    if [ -f "$BRIGHTNESS_FILE" ]; then
        BRIGHTNESS=$(cat "$BRIGHTNESS_FILE")
    else
        BRIGHTNESS=90
    fi

    # Restore brightness
    ddcutil -d "$MONITOR" setvcp 10 "$BRIGHTNESS" &
done
wait
