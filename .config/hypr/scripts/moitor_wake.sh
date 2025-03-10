#!/bin/sh

CACHE_BRIGHTNESS=$HOME/.cache/ddc_backup 
mkdir -p $CACHE_BRIGHTNESS

for MONITOR in $(ddcutil detect | grep "Display" | awk '{print $2}'); do
    # Get current brightness (VCP 10)
    CURRENT_BRIGHTNESS=$(ddcutil -d "$MONITOR" getvcp 10 | awk '{print $NF}')
    SHADOW_BRIGHTNESS = 0
    
    echo "$CURRENT_BRIGHTNESS" > ${CACHE_BRIGHTNESS}/brightness_$MONITOR

    # Bg change brightness
    ddcutil -d "$MONITOR" setvcp 10 $SHADOW_BRIGHTNESS &
done
wait
