==Prefix = Ctrl + B==
Configuration File = /home/sumit/.tmux.conf
Extra Resource = https://tmuxcheatsheet.com/
![[Tmux.png|382]]

---
Create
- Pane =
	- Vertical = Prefix + %
	- Horizontal = Prefix + "
- Windows = Prefix + C
- Session = `tmux new -s <session-name>` or `tmux`
---
Rename
- Window Respective = 
	- `tmux rename-window`
	- Prefix + ,
- Session =
	- in respective session = `tmux rename-session <new-session-name>`
	- out session = `tmux rename-session -t <current-session-name> <new-session-name>`
---
List Tmux Session
- `tmux ls`
- `tmux list-session`
---
Attach/Detach/Switch Session
- Attach = (argument =>attach or a)
	- `tmux <argument> -t <session-name>`
	- `tmux a` = attach recent one
- Detach = Prefix + D
- Switch Session in between = Prefix + S
---
Close/Delete
- Pane = Prefix + X
- Window = Prefix + &
- Session (`t` argument means target)
	- Outside Tmux = `tmux kill-session -t <session_name>`
	- Inside Respective Session = `tmux kill-session`
	- Simple Kill/Exit Every Pane & Windows or Ctrl + D
---
Navigate
- Window = Prefix + p/n or Prefix + 0-9
- Pane = Prefix + Arrow key
---
Misc
- Reload config = `tmux source-file ~/.tmux.conf`
- Show all keybindings = `Prefix + ?`
- Zoom/full-screen toggle = `Prefix + Z`
- Resize = `Prefix + Ctrl/Alt + Arrow key`