function spotify_notify
    set -l tmp_art "/tmp/spotify_art.png"

    playerctl --player=spotify --follow metadata --format '{{mpris:artUrl}}|{{title}}|{{artist}}' | while read -l line
        set -l parts (string split '|' "$line")
        set -l url $parts[1]
        set -l title $parts[2]
        set -l artist $parts[3]

        if test -n "$url"
            curl -s "$url" -o "$tmp_art"
            notify-send -a "Spotify" -i "$tmp_art" "$title" "$artist"
        else
            notify-send -a "Spotify" -i "spotify" "$title" "$artist"
        end
    end
end
