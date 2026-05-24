#!/bin/bash

STATE_FILE="/tmp/hypr_black_mode"
BLACK_WALLPAPER="$HOME/.config/hypr/wallpapers/black.webp"
NORMAL_WALLPAPER="$HOME/.config/hypr/wallpapers/gruvbox2.png"

if [ -f "$STATE_FILE" ]; then
    # Restore normal state
    hyprctl keyword general:col.active_border "rgba(98971aee)"
    hyprctl keyword general:col.inactive_border "rgba(121212ee)"

    hyprctl hyprpaper preload "$NORMAL_WALLPAPER"
    hyprctl hyprpaper wallpaper ",$NORMAL_WALLPAPER"
    hyprctl hyprpaper unload "$BLACK_WALLPAPER"

    rm "$STATE_FILE"
else
    # Enable black mode
    hyprctl keyword general:col.active_border "rgba(000000ee)"
    hyprctl keyword general:col.inactive_border "rgba(000000ee)"

    hyprctl hyprpaper preload "$BLACK_WALLPAPER"
    hyprctl hyprpaper wallpaper ",$BLACK_WALLPAPER"
    hyprctl hyprpaper unload "$NORMAL_WALLPAPER"

    touch "$STATE_FILE"
fi
