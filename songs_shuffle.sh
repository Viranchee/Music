# Search and play mp4 video
ytsearch() {
  yt-dlp -f mp4 ytsearch:"$@" -o - 2>/dev/null | ffplay -autoexit -i - &>/dev/null
}

# Play specific link
ytvideo() {
  yt-dlp -f mp4 $1 -o - 2>/dev/null | ffplay -autoexit -i - &>/dev/null
}

# Search and play music
ytmusic() {
  yt-dlp -f bestaudio ytsearch:"$@" -o - 2>/dev/null | ffplay -nodisp -autoexit -i - &>/dev/null
}

# Play Random music from file by streaming over yt
musicShuffle() {
  DefaultFile="./songslist.txt"
  Playlist="${1:-$DefaultFile}"
  # for (( ; ; )); do
  number_of_songs=$(wc -l $Playlist | awk '{print $1}')
  rand=$((1 + RANDOM % $number_of_songs))
  song_name=$(tail -n $rand $Playlist | head -n 1)
  echo Now Playing: $song_name
  # ytmusic $song_name
  ytsearch $song_name
  # done
}
