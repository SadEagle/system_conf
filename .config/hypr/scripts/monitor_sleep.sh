#!/bin/sh

if [ -z $2 ]; then
    SHADOW_BRIGHTNESS=0
else
    SHADOW_BRIGHTNESS=$1
fi

# Get current brightness (VCP 10)
for MONITOR_ID in $(ddcutil detect | grep "Display" | awk '{print $2}'); do
    ddcutil -d $MONITOR_ID setvcp 10 $SHADOW_BRIGHTNESS &
done
wait
