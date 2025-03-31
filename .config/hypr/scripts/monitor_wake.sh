#!/bin/sh

if [ -z $1 ]; then
    SHADOW_BRIGHTNESS=100
else
    SHADOW_BRIGHTNESS=$1
fi

for MONITOR_ID in $(ddcutil detect | grep "Display" | awk '{print $2}'); do
    # Restore brightness
    ddcutil -d $MONITOR_ID setvcp 10 $SHADOW_BRIGHTNESS &
done
wait
