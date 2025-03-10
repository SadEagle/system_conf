#!/bin/sh

# Define the cache directory to store brightness values
CACHE_BRIGHTNESS=$HOME/.cache/ddc_backup 
mkdir -p "$CACHE_BRIGHTNESS"

change_brightness_single() {
    MONITOR_ID=$1
    VALUE=$2
    CURRENT_BRIGHTNESS=$(ddcutil -d "$MONITOR_ID" getvcp 10 | awk '{print $NF}')
    NEW_BRIGHTNESS=$(($CURRENT_BRIGHTNESS+$VALUE))
    ddcutil -d "$MONITOR_ID" setvcp 10 "$VALUE" &
    echo $NEW_BRIGHTNESS > ${CACHE_BRIGHTNESS}/brightness_$MONITOR &
    wait
}

change_brightness_all() {
    VALUE=$1
    for MONITOR_ID in $(ddcutil detect | grep "Display" | awk '{print $2}'); do
        CURRENT_BRIGHTNESS=$(ddcutil -d "$MONITOR_ID" getvcp 10 | awk '{print $NF}')
        NEW_BRIGHTNESS=$(($CURRENT_BRIGHTNESS+$VALUE))
        ddcutil -d "$MONITOR_ID" setvcp 10 "$VALUE" &
        echo $NEW_BRIGHTNESS > ${CACHE_BRIGHTNESS}/brightness_$MONITOR &
    done
    wait
}

# Parse flags
case "$1" in
    -c)
        if [ -z "$2" ] || [ -z "$3" ]; then
            echo "Usage: $0 -c <monitor_id> <brightness_value>"
            exit 1
        fi
        change_brightness_single "$2" "$3"
        ;;
    -a)
        if [ -z "$2" ]; then
            echo "Usage: $0 -a <brightness_value>"
            exit 1
        fi
        change_brightness_all "$2"
        ;;
    *)
        echo "Invalid option: $1"
        exit 1
        ;;
esac

