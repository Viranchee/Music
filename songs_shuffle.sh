ytsearch() {
  DefaultFormat="mp4"
  Format="${2:-$DefaultFormat}"
  yt-dlp -f $Format ytsearch:$1 -o - 2>/dev/null | ffplay -autoexit -i - &>/dev/null
}

ytvideo() {
  ytsearch $1 mp4
}

ytmusic() {
  yt-dlp -f bestaudio ytsearch:$1 -o - 2>/dev/null | ffplay -nodisp -autoexit -i - &>/dev/null
}

shuffle() {
  DefaultFile="./songslist.txt"
  Playlist="${1:-$DefaultFile}"
  # for (( ; ; )); do
  number_of_songs=$(wc -l $Playlist | awk '{print $1}')
  rand=$((1 + RANDOM % $number_of_songs))
  song_name=$(tail -n $rand $Playlist | head -n 1)
  echo Now Playing: $song_name
  # ytmusic $song_name
  ytvideo $song_name
  # done
}