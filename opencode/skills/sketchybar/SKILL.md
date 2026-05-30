---
name: sketchybar
description: Configure and customize SketchyBar status bar (Lua/SbarLua)
---

## Config Structure
- `~/.config/sketchybar/bar.lua` — Bar appearance (height, color, border, margin, corner_radius)
- `~/.config/sketchybar/colors.lua` — Color definitions
- `~/.config/sketchybar/items/*.lua` — Individual items (apple, calendar, etc.)
- `~/.config/sketchybar/icons.lua` — Icon definitions
- `~/.config/sketchybar/default.lua` — Default item properties
- `~/.config/sketchybar/init.lua` — Entry point

## Reload
```bash
sketchybar --reload
```

## Color Format
ARGB hex: `0xAARRGGBB` where AA is alpha (ff=opaque, 00=transparent)

## Bar Properties
- `height` — Bar height in pixels
- `color` — Background color (ARGB)
- `border_color` — Border color
- `border_width` — Border thickness
- `margin` — Space outside bar (positive shrinks, negative extends)
- `corner_radius` — Roundness of corners
- `y_offset` — Vertical shift of items within the bar
- `padding_left/right` — Space between bar edge and items
