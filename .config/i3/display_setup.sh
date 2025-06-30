#!/bin/bash

INTERNAL="eDP-1"
EXTERNAL=$(xrandr | grep " connected" | grep -v "$INTERNAL" | cut -d ' ' -f1)

if [ -n "$EXTERNAL" ]; then
    xrandr --output "$INTERNAL" --auto --primary \
           --output "$EXTERNAL" --auto --right-of "$INTERNAL"

    # Move workspaces 2–10 to external
    for i in {2..10}; do
        i3-msg "workspace $i; move workspace to output $EXTERNAL"
    done

    i3-msg "workspace 1"
else
    xrandr --output "$INTERNAL" --auto --primary
    for i in {1..10}; do
        i3-msg "workspace $i; move workspace to output $INTERNAL"
    done
fi
