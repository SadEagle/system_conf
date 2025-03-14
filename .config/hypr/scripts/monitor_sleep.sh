#!/bin/sh

CACHE_BRIGHTNESS=$HOME/.cache/ddc_backup 
mkdir -p $CACHE_BRIGHTNESS
if [ -z $2 ]; then
    SHADOW_BRIGHTNESS=0
else
    SHADOW_BRIGHTNESS=$2
fi

for MONITOR_ID in $(ddcutil detect | grep "Display" | awk '{print $2}'); do
    # Get current brightness (VCP 10)
    CURRENT_BRIGHTNESS=$(ddcutil -d $MONITOR_ID getvcp 10 | awk '{print $NF}')

    CAHCE_MONITOR_PATH=${CACHE_BRIGHTNESS}/brightness_$MONITOR_ID
    CURRENT_BRIGHTNESS_CACHE=$(cat $CAHCE_MONITOR_PATH)
    
    if [ $CURRENT_BRIGHTNESS -ne $CURRENT_BRIGHTNESS_CACHE ]; then
        echo "$CURRENT_BRIGHTNESS" > ${CACHE_BRIGHTNESS}/brightness_$MONITOR_ID
    fi

    # Bg change brightness
    ddcutil -d $MONITOR_ID setvcp 10 $SHADOW_BRIGHTNESS &
done
wait
