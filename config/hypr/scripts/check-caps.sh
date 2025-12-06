#!/usr/bin/env bash

# Get caps lock state
CAPS_STATE=$(xset q | grep "Caps Lock" | awk '{print $4}')

if [ "$CAPS_STATE" = "on" ]; then
    echo "⚠️  CAPS LOCK IS ON"
else
    echo ""
fi
