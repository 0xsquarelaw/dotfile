# tmux Configuration

A custom `tmux` configuration with ergonomic key bindings, vi-style controls, a clean status bar theme, and quality-of-life tweaks for a productive terminal workflow.

> **New to tmux?** tmux lets you have multiple terminals inside one terminal window. You can split it, have tabs (called windows), and even detach and come back later without losing anything.

---

## Installation

1. Copy the config file to your home directory:

   ```bash
   cp _tmux.conf ~/.tmux.conf
   ```

2. Reload the configuration inside an active tmux session:

   ```
   Prefix + r
   ```

   Or source it directly from the shell:

   ```bash
   tmux source-file ~/.tmux.conf
   ```

---

## What is a Prefix Key?

Almost every tmux shortcut requires you to press a **prefix key** first, then the actual key. The default is `Ctrl+b`, but this config changes it to:

| Key       | Description          |
|-----------|----------------------|
| `Ctrl+j`  | Primary prefix key   |
| `Ctrl+f`  | Secondary prefix key |

So when you see `Prefix + v`, it means: press `Ctrl+j`, release, then press `v`.

---

## Key Bindings

### Pane Management

Panes let you split your terminal window into sections — like two terminals side by side.

| Key                    | Action                              |
|------------------------|-------------------------------------|
| `Prefix + v`           | Split pane vertically (side by side) |
| `Prefix + h`           | Split pane horizontally (top/bottom) |
| `Alt + ←/→/↑/↓`       | Switch between panes (no prefix needed) |
| `Prefix + y`           | Toggle synchronize-panes (type in all panes at once) |

### Window Management

Windows are separate tabs inside tmux. Each window can have its own panes.

| Key                    | Action                              |
|------------------------|-------------------------------------|
| `Shift + ←`            | Go to previous window               |
| `Shift + →`            | Go to next window                   |
| `Ctrl+Shift + ←`       | Move current window one position left |
| `Ctrl+Shift + →`       | Move current window one position right |

> Windows are numbered starting from **1** (not 0), which makes them easier to reach on the keyboard.

### Copy & Paste (vi mode)

tmux has its own clipboard. To copy text from terminal output:

1. `Prefix + [` — enter copy mode (you can now scroll and select)
2. Use arrow keys to move, then press `v` to start selecting text
3. Press `y` to copy the selection and exit copy mode
4. `Prefix + p` — paste what you copied

It works like Vim — `v` to select, `y` to yank (copy).

| Key                            | Action                         |
|--------------------------------|--------------------------------|
| `Prefix + [` then `v`          | Begin text selection           |
| `y`                            | Copy selection and exit        |
| `Prefix + p`                   | Paste buffer                   |

### Utilities

| Key              | Action                                 |
|------------------|----------------------------------------|
| `Prefix + r`     | Reload `~/.tmux.conf` and confirm      |
| `Prefix + L`     | Clear pane history (including scrollback) |
| `Prefix + y`     | Sync panes — useful for running the same command across multiple SSH sessions |

---

## Features & Settings

These are set in the config and are always on — no action needed.

### General

- **256-color terminal** support (`xterm-256color`)
- **Window & pane indexing starts at 1** (instead of 0) for easier keyboard reach
- **Automatic window renaming** based on the running process
- **Window titles** synced to the terminal title bar
- **Mouse support** enabled — click to focus panes/windows, scroll freely, and drag to resize panes

### Performance

- **No escape-key delay** (`escape-time 0`) — removes the wait when pressing Escape, which is important for Vim/Neovim users
- **No repeat-time** after window switching, so arrow keys respond immediately
- **Status messages** displayed for 3 seconds for readability

### Activity Monitoring

- Tabs **highlight when activity occurs** in a background window (e.g. when a long command finishes)
- Visual pop-up alert is disabled (silent monitoring only)
- Bell monitoring is disabled

---

## Theme

The status bar and UI use a clean green-on-black palette.

| Element                   | Style                                   |
|---------------------------|-----------------------------------------|
| Status bar background     | Black                                   |
| Status bar foreground     | Green                                   |
| Active window tab         | Bold, blue background, white text       |
| Inactive window tab       | Bold, green text                        |
| Activity tab              | Bold, black background, white text      |
| Active pane border        | Green                                   |
| Inactive pane border      | White                                   |
| Message/prompt bar        | Black background, white text            |

---

## Status Bar

The bar at the bottom of the screen shows:

- **Left:** `⭐ <hostname> [session-name]`
- **Right:** `𝄞 YYYY-Mon-DD HH:MM`

Updated every **60 seconds**, centered layout.

---

## Requirements

- tmux **2.1+** (for mouse mode syntax)
- A terminal with **256-color** and **UTF-8** support for the status bar icons to render correctly