# radio.sh
A minimal terminal radio and YouTube player using `fzf` and `mpv`.

---

## Dependencies

| Tool | Purpose | Install |
|------|---------|---------|
| `mpv` | Audio playback | `sudo apt install mpv` / `brew install mpv` |
| `fzf` | Interactive menu | `sudo apt install fzf` / `brew install fzf` |
| `yt-dlp` | YouTube stream resolution | `https://github.com/yt-dlp/yt-dlp/wiki/Installation#apt` |

> `yt-dlp` must be available in `$PATH`. mpv uses it internally via `--ytdl-format=bestaudio`.

---

## Setup

```bash
chmod +x radio.sh
touch ~/radio-list.txt    # add radio stations
touch ~/youtube-list.txt  # add YouTube videos/playlists
./radio.sh
```

---

## List File Format

Two separate files at `~/radio-list.txt` and `~/youtube-list.txt`. One entry per line:

```
Name, URL
```

### radio-list.txt
```
BBC World Service, https://stream.live.vc.bbcmedia.co.uk/bbc_world_service
Australian Indian Radio, http://webcast.indianradio.net.au:8000/
```

### youtube-list.txt
```
Lofi Girl Live, https://www.youtube.com/watch?v=jfKfPfyJRdk
Jazz Collection, https://www.youtube.com/playlist?list=...
```

---

## Menu

| Option | Action |
|--------|--------|
| Play | Choose source, then pick a station |
| Stop | Stop current playback |
| Exit | Stop and quit |

Status line in the header shows `▶ Playing` or `■ Stopped`.

---

## Play Flow

```
Radio > Play
  └── Source > Radio / YouTube
        └── Station > <fuzzy pick>
```

Select `⬅ Back` or press `Esc` at any level to return to the previous menu.

---

## Terminal Tab Title

Shows `▶ Name` while playing, resets to `radio` on stop, clears on exit.