function ytstream
    set -l format bestvideo
    set -l playbackSpeed 1.0
    set -l query "ytsearch:"
    set -l name "URL"
    set -l ffdisplay ""
    # If argument list is empty
    if test (count $argv) -eq 0
        echo "Usage: ytstream [OPTIONS] [QUERY]"
        echo "OPTIONS:"
        echo "  -s, --search    Search for a video"
        echo "  -u, --url       Play a video from a URL"
        echo "  -p, --playlist  Play a playlist"
        echo "  -a, --audio     Play audio only"
        echo "  -S, --speed     Playback speed"
        echo "  -h, --help      Show this help message"
        return 1
    end
    getopts $argv | while read -l key value
        switch $key
            case _
                set query $query\"$value\"
                set name $value
            case "search" "s"
                set query $query\"$value\"
                set name $value
            case "url" "u"
                set query "$value"
            case "playlist" "p"
                set query "$value"
            case "speed" "S"
                set playbackSpeed "$value"
            case "audio" "a"
                set format "bestaudio"
                set ffdisplay "-nodisp"
        end
    end
    echo $query
    echo $ffdisplay
    # echo "yt-dlp $query -o - 2>/dev/null | ffplay -af "atempo=$playbackSpeed" $ffdisplay -autoexit -i - &>/dev/null" | pbcopy
    # yt-dlp $query -o - 2>/dev/null | ffplay -af "atempo=$playbackSpeed" $ffdisplay -autoexit -i - &>/dev/null
    echo "yt-dlp $query -o - 2>/dev/null | ffplay -af "atempo=$playbackSpeed" -window_title=$name -autoexit -i - &>/dev/null"
    echo "yt-dlp $query -o - 2>/dev/null | ffplay -af "atempo=$playbackSpeed" -window_title=$name -autoexit -i - &>/dev/null" | pbcopy
    yt-dlp $query -o - 2>/dev/null | ffplay -af "atempo=$playbackSpeed" -autoexit -i - &>/dev/null
end
