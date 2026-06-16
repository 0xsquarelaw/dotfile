#!/usr/bin/env bash
RADIO_FILE="$HOME/radio-list.txt"
YT_FILE="$HOME/youtube-list.txt"

set_title() { printf '\033]0;%s\007' "$1"; }

stop_playback() { pkill mpv 2>/dev/null; }

play() {
  local name="$1" url="$2"
  stop_playback
  set_title "▶ $name"
  mpv --no-video --ytdl-format=bestaudio "$url" >/dev/null 2>&1 &
}

parse_line() {
  NAME=""; URL=""
  if [[ "$1" =~ ^([^,]+),[[:space:]]*(.+)$ ]]; then
    NAME="${BASH_REMATCH[1]}"; URL="${BASH_REMATCH[2]}"
    NAME="${NAME#"${NAME%%[! ]*}"}"; NAME="${NAME%"${NAME##*[! ]}"}"
    URL="${URL%"${URL##*[! ]}"}"
  fi
}

get_info() {
  local file="$1" target="$2"
  INFO_URL=""
  while IFS= read -r line; do
    [[ -z "$line" ]] && continue
    parse_line "$line"
    [[ "$NAME" == "$target" ]] && { INFO_URL="$URL"; return; }
  done < "$file"
}

pick_from_file() {
  local file="$1"
  {
    printf "⬅ Back\n"
    while IFS= read -r line; do
      [[ -z "$line" ]] && continue
      parse_line "$line"
      [[ -n "$NAME" ]] && printf "%s\n" "$NAME"
    done < "$file"
  } | fzf --prompt="Station > " --height=40% --border
}

play_from() {
  local file="$1" sel
  sel=$(pick_from_file "$file") || return
  [[ "$sel" == "⬅ Back" ]] && return
  get_info "$file" "$sel"
  [[ -n "$INFO_URL" ]] && play "$sel" "$INFO_URL"
}

status() {
  pgrep mpv >/dev/null && echo "▶ Playing" || echo "■ Stopped"
}

home_menu() {
  printf "Play\nStop\nExit\n" \
    | fzf --prompt="Radio > " --height=40% --border --header="$(status)"
}

source_menu() {
  printf "⬅ Back\nRadio\nYouTube\n" \
    | fzf --prompt="Source > " --height=40% --border
}

while true; do
  choice=$(home_menu) || exit
  case "$choice" in
    Play)
      src=$(source_menu)
      case "$src" in
        "⬅ Back") continue ;;
        Radio)   play_from "$RADIO_FILE" ;;
        YouTube) play_from "$YT_FILE"    ;;
      esac
      ;;
    Stop) stop_playback; set_title "radio" ;;
    Exit) stop_playback; set_title ""; exit ;;
  esac
done