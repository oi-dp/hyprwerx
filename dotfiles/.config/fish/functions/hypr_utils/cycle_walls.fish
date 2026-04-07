function cycle_walls
    set -l WALLPAPER_DIR "$HOME/Pictures/walls"
    set -l CACHE_FILE "$HOME/.cache/cycle_walls"

    set -l images (find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \) | sort)

    if test -z "$images"
        notify-send "Cycling Walls" "No wallpapers found in $WALLPAPER_DIR"
        return 1
    end

    set -l current_wallpaper ""
    if test -f "$CACHE_FILE"
        set current_wallpaper (cat "$CACHE_FILE")
    end

    set -l next_wallpaper ""
    set -l found_current false
    set -l first_wallpaper ""

    for img in $images
        if test -z "$first_wallpaper"
            set first_wallpaper "$img"
        end

        if test "$found_current" = true
            set next_wallpaper "$img"
            break
        end

        if test "$img" = "$current_wallpaper"
            set found_current true
        end
    end

    if test -z "$next_wallpaper"
        set next_wallpaper "$first_wallpaper"
    end

    set -l monitors (hyprctl monitors | grep "Monitor" | awk '{print $2}')

    hyprctl hyprpaper preload "$next_wallpaper"

    for monitor in $monitors
        hyprctl hyprpaper wallpaper "$monitor,$next_wallpaper"
    end

    if test -n "$current_wallpaper" -a "$current_wallpaper" != "$next_wallpaper"
        hyprctl hyprpaper unload "$current_wallpaper"
    end

    echo "$next_wallpaper" >"$CACHE_FILE"
end
