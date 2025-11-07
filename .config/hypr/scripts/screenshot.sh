#!/bin/bash
temp=$(mktemp --suffix=.png)
if grim -g "$(slurp -d)" "$temp"; then
    filename=~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png
    mv "$temp" "$filename"
    wl-copy < "$filename"
    notify-send -i "$filename" "Screenshot" "Saved to Pictures and copied to clipboard"
else
    rm -f "$temp"
fi
