<div align="center">

# 🚀 sketchybar-config

**A sleek macOS status bar powered by [SketchyBar](https://github.com/FelixKratz/SketchyBar) with Aerospace integration**

[![macOS](https://img.shields.io/badge/macOS-12%2B-F8F8F2?style=for-the-badge&logo=apple)](https://www.apple.com/macos/)
[![SketchyBar](https://img.shields.io/badge/SketchyBar-Latest-FF79C6?style=for-the-badge)](https://github.com/FelixKratz/SketchyBar)
[![Aerospace](https://img.shields.io/badge/Aerospace-win-F8F8F2?style=for-the-badge)](https://github.com/nikitabobko/AeroSpace)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-FFB86C?style=for-the-badge)](https://www.gnu.org/licenses/gpl-3.0)

</div>

---

## 📸 Preview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  ① ② ③ ④ ⑤ ⑥ ⑦ ⑧ ⑨    │ SLO 72°F  🌧️  │  🔋 100%  │  📶 MyWiFi   │
└─────────────────────────────────────────────────────────────────────────────┘
        ↑ your workspaces                 ↑ weather    ↑ battery    ↑ wifi
```

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| 🎨 **Tokyo Night** | Cyberpunk-inspired dark theme (🎭 `#1a1b26`, 🟣 `#bb9af7`, 🔵 `#7aa2f7`) |
| 🖥️ **Workspace Indicators** | Dynamic aerospace integration showing apps per workspace |
| 🌤️ **Weather Widget** | Real-time weather from wttr.in |
| 📶 **WiFi Status** | Live network monitoring |
| 🔋 **Battery** | Smart battery with charging indicator |
| ⌨️ **Custom Fonts** | SF Pro + Nerd Fonts for maximum Based Points™ |

---

## 🚀 Quick Install

```bash
git clone https://github.com/mumeez/mumeez-mac-setup.git
cd sketchybar-new

chmod +x install.sh
./install.sh
```

---

## ⚙️ Configuration

### Workspace Setup

Single monitor setup in `items/aerospace_workspaces.lua`:

```lua
local WORKSPACE_LAYOUT = {
    { display = 1, workspaces = { "1", "2", "3", "4", "5", "6", "7", "8", "9" } },
}
```

### Weather Location

Update in `items/widgets/weather.lua`:

```lua
sbar.exec([[curl -s 'https://wttr.in/San%20Luis%20Obispo?format=%t+%C' | tr -d '\n']], ...)
```

### WiFi Interface

Find your interface:

```bash
networksetup -listallhardwareports
```

Update in `items/widgets/wifi.lua` (currently `en0`).

---

## 📁 File Structure

```
sketchybar/
├── sketchybarrc              # ← entry point (load this in sketchybar)
├── colors.lua               # Tokyo Night palette
├── settings.lua             # Global styles
├── init.lua                 # Framework loader
├── items/
│   ├── aerospace_workspaces.lua  # Workspace integration
│   ├── wifi.lua               # WiFi widget
│   ├── weather.lua            # Weather widget
│   └── battery.lua            # Battery widget
└── helpers/
    └── app_icons.lua         # App icon mappings
```

---

## 🎯 Key Bindings

| Action | Shortcut |
|--------|----------|
| Switch workspace | `aerospace workspace N` |
| Move window | Right-click workspace |

---

## 🔧 Troubleshooting

```bash
# Restart sketchybar
sketchybar --restart

# View logs
log stream --predicate 'subsystem == "com.felixkratz.sketchybar"'

# Test weather
curl -s 'https://wttr.in/San%20Luis%20Obispo?format=%t+%C'
```

---

## 🙏 Credits

- **[FelixKratz](https://github.com/FelixKratz)** — SketchyBar & SbarLua
- **[kvndrsslr](https://github.com/kvndrsslr/sketchybar-app-font)** — App icon font
- **[Tokyo Night](https://github.com/folke/tokyonight.nvim)** — Colorscheme inspo

---

## 📜 License

[GPL v3](LICENSE) — Free as in freedom.

---

<div align="center">

**⌨️ Built with ☕ on macOS**

*Tokyo Night aesthetic • Aerospace powered • Productivity enhanced*

</div>