#!/usr/bin/env bash

# Check if battery exists
if [ ! -d /sys/class/power_supply/BAT* ]; then
    exit 0
fi

# Get battery info
BATTERY_PATH=$(find /sys/class/power_supply -name "BAT*" | head -n1)
if [ -z "$BATTERY_PATH" ]; then
    exit 0
fi

CAPACITY=$(cat "$BATTERY_PATH/capacity" 2>/dev/null || echo "0")
STATUS=$(cat "$BATTERY_PATH/status" 2>/dev/null || echo "Unknown")

# Choose icon based on status and capacity
if [ "$STATUS" = "Charging" ]; then
    ICON="󰂄"
elif [ "$CAPACITY" -ge 90 ]; then
    ICON="󰁹"
elif [ "$CAPACITY" -ge 70 ]; then
    ICON="󰂀"
elif [ "$CAPACITY" -ge 50 ]; then
    ICON="󰁾"
elif [ "$CAPACITY" -ge 30 ]; then
    ICON="󰁼"
elif [ "$CAPACITY" -ge 10 ]; then
    ICON="󰁺"
else
    ICON="󰂃"
fi

echo "$ICON $CAPACITY%"
