#!/bin/bash
ZYXTARCH="$HOME/.config/zyxtarch"
WALLPAPER_DIR="${WALLPAPER_DIR:-$ZYXTARCH/wallpapers}"


cd "$WALLPAPER_DIR" || exit

vicinae_wallpaper_picker() {
    WALLPAPER=$(
        find "$WALLPAPER_DIR" -type f \( \
        -iname "*.png" -o \
        -iname "*.jpg" -o \
        -iname "*.jpeg" -o \
        -iname "*.gif" \
        \) | sort | vicinae dmenu \
        -W 1600 -H 700 \
        -p "Search for your wallpaper" \
        -s "Wallpapers"
    )

    [ -n "$WALLPAPER" ] && rice wal "$WALLPAPER"
}



vicinae_wallpaper_picker