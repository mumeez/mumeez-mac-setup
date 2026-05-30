---
name: aerospace
description: Configure AeroSpace tiling window manager
---

## Config
- `~/.config/aerospace/aerospace.toml` — Main config

## Reload
```
aerospace reload-config
```
Or keybinding: alt-shift-r

## Key Sections
- `[gaps]` — inner/outer gaps between windows
- `[mode.main.binding]` — Keybindings for main mode
- `[mode.service.binding]` — Keybindings for service mode

## Common Tasks
- `outer.top` — Gap at top of screen (accounts for sketchybar)
- `inner.horizontal/vertical` — Gaps between windows
- Workspace binding: `alt-1` through `alt-9`
- Move window to workspace: `alt-shift-1` through `alt-shift-9`
