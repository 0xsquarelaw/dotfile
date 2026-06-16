# radio.sh
A minimal terminal radio player using `fzf` and `mpv`.

---
## Dependencies
| Tool | Purpose | Install |
|------|---------|---------|
| `mpv` | Audio playback | `sudo apt install mpv` / `brew install mpv` |
| `fzf` | Interactive menu | `sudo apt install fzf` / `brew install fzf` |
| `yt-dlp` | Stream URL resolution (YouTube etc.) | `pip install yt-dlp` |

> `yt-dlp` must be available in `$PATH`. mpv uses it internally via `--ytdl-format=bestaudio`.

---
## Setup
```bash
chmod +x radio.sh
touch \~/stations.txt   # add your stations (see format below)
./radio.sh
```
---
## stations.txt Format
Located at `\~/stations.txt`. One station per line.

### With type prefix
```
type: Name, url
```
| Type | Color | Example |
|------|-------|---------|
| `radio` | Yellow | `radio: BBC World Service, https://stream.live.vc.bbcmedia.co.uk/bbc\_world\_service` |
| `yt-video` | Red | `yt-video: Lofi Girl Live, https://www.youtube.com/watch?v=jfKfPfyJRdk` |
| `yt-playlist` | Orange | `yt-playlist: Jazz Collection, https://www.youtube.com/playlist?list=...` |

### Without type prefix
No color tag is shown in the picker.
```
Name, url
```

```
India, https://www.youtube.com/watch?v=6qeFCdscf58
```
### Full example
```
radio: BBC World Service, https://stream.live.vc.bbcmedia.co.uk/bbc\_world\_service
radio: Australian Indian Radio, http://webcast.indianradio.net.au:8000/
yt-video: Lofi Girl Live, https://www.youtube.com/watch?v=jfKfPfyJRdk
yt-playlist: Hindi Hits, https://www.youtube.com/playlist?list=...
yt-playlist: Jazz Collection, https://www.youtube.com/playlist?list=...
India, https://www.youtube.com/watch?v=6qeFCdscf58
```

## Menu

| Option | Action |
|--------|--------|
| Play | Open station picker |
| Stop | Stop current playback |
| Exit | Stop and quit |

Status line shows current state — `▶ Now Playing: \[type] Name` or `■ Stopped`.

---
## Station Picker
- Fuzzy search by name or type (e.g. type `radio` to filter only radio streams)

- Select `⬅ Back` or press `Esc` to return without playing
---
## Terminal Tab Title
Shows `▶ Name` while playing, clears on exit.