#!/usr/bin/env bash
FILE="$HOME/stations.txt"
STATE="/tmp/radio_now"
> "$STATE"

YELLOW='\033[33m'
RED='\033[31m'
ORANGE='\033[38;5;208m'
RESET='\033[0m'

set_title() { printf '\033]0;%s\007' "$1"; }

play() {
  local type="$1" name="$2" url="$3"
  pkill mpv 2>/dev/null
  echo "$type|$name" > "$STATE"
  set_title "▶ $name"
  mpv --no-video --ytdl-format=bestaudio "$url" >/dev/null 2>&1 &
}

parse_line() {
  TYPE=""; NAME=""; URL=""
  if [[ "$1" =~ ^([a-z-]+):\ *(.+),\ *(.+)$ ]]; then
    TYPE="${BASH_REMATCH[1]}"; NAME="${BASH_REMATCH[2]}"; URL="${BASH_REMATCH[3]}"
  elif [[ "$1" =~ ^(.+),\ *(.+)$ ]]; then
    NAME="${BASH_REMATCH[1]}"; URL="${BASH_REMATCH[2]}"
  fi
  NAME="${NAME#"${NAME%%[! ]*}"}"; NAME="${NAME%"${NAME##*[! ]}"}"
  URL="${URL#"${URL%%[! ]*}"}";   URL="${URL%"${URL##*[! ]}"}"
}

get_info() {
  INFO_TYPE=""; INFO_URL=""
  while IFS= read -r line; do
    [[ -z "$line" ]] && continue
    parse_line "$line"
    if [[ "$NAME" == "$1" ]]; then
      INFO_TYPE="$TYPE"; INFO_URL="$URL"; return
    fi
  done < "$FILE"
}

colored_name() {
  case "$1" in
    radio)       printf "${YELLOW}[radio]${RESET} %s\n"       "$2" ;;
    yt-video)    printf "${RED}[yt-video]${RESET} %s\n"       "$2" ;;
    yt-playlist) printf "${ORANGE}[yt-playlist]${RESET} %s\n" "$2" ;;
    *)           printf "%s\n"                                 "$2" ;;
  esac
}

pick_station() {
  {
    printf "⬅ Back\n"
    while IFS= read -r line; do
      [[ -z "$line" ]] && continue
      parse_line "$line"
      colored_name "$TYPE" "$NAME"
    done < "$FILE"
  } | fzf --ansi --prompt="Station > " --height=40% --border
}

status() {
  if pgrep mpv >/dev/null && [ -s "$STATE" ]; then
    local t name stored
    stored=$(cat "$STATE")
    t="${stored%%|*}"; name="${stored##*|}"
    [ -n "$t" ] && echo "▶ Now Playing: [$t] $name" || echo "▶ Now Playing: $name"
  else
    echo "■ Stopped"
  fi
}

home_menu() {
  printf "Play\nStop\nExit\n\n%s\n" "$(status)" \
    | fzf --prompt="Radio > " --height=40% --border
}

while true; do
  choice=$(home_menu) || exit
  case "$choice" in
    Play)
      sel=$(pick_station) || continue
      [ "$sel" = "⬅ Back" ] && continue
      plain=$(printf '%s' "$sel" | sed 's/\x1b\[[0-9;]*m//g; s/^\[[a-z-]*\] //')
      get_info "$plain"
      [ -n "$INFO_URL" ] && play "$INFO_TYPE" "$plain" "$INFO_URL"
      ;;
    Stop)
      pkill mpv 2>/dev/null
      > "$STATE"
      set_title "radio"
      ;;
    Exit)
      pkill mpv 2>/dev/null
      set_title ""
      exit
      ;;
  esac
done