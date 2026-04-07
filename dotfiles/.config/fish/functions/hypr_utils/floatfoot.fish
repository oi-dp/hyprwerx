function floatfoot
    set -l WIN_JSON (hyprctl activewindow -j)
    set -l WIN_CLASS (echo "$WIN_JSON" | jq -r '.class')
    set -l WIN_FLOATING (echo "$WIN_JSON" | jq -r '.floating')

    # Only apply custom size/position for footclient
    if test "$WIN_CLASS" = "footclient" -o "$WIN_CLASS" = "foot"
        if test "$WIN_FLOATING" = "false"
            hyprctl dispatch togglefloating
            sleep 0.05
            hyprctl dispatch resizeactive exact 800 500
        else
            hyprctl dispatch togglefloating
        end
    else
        hyprctl --batch "dispatch togglefloating ; dispatch fullscreen 1"
    end
end
