<div align="center">

# 🎨 SketchyBar Configuration

**A Tokyo Night-inspired SketchyBar setup for macOS with Aerospace integration**

[![macOS](https://img.shields.io/badge/macOS-12%2B-000000?style=for-the-badge&logo=apple)](https://www.apple.com/macos/)
[![SketchyBar](https://img.shields.io/badge/SketchyBar-Latest-4285F4?style=for-the-badge)](https://github.com/FelixKratz/SketchyBar)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg?style=for-the-badge)](https://www.gnu.org/licenses/gpl-3.0)
[![Stars](https://img.shields.io/github/stars/NoamFav/sketchybar?style=flat&label=stars)](https://github.com/NoamFav/sketchybar/stargazers)
[![Fork](https://img.shields.io/github/forks/NoamFav/sketchybar?style=flat&label=forks)](https://github.com/NoamFav/sketchybar/network)

</div>

---

## ⚡ Quick Install

```bash
git clone https://github.com/NoamFav/sketchybar.git
cd sketchybar
chmod +x install.sh
./install.sh
```

---

## 📸 Preview

<p align="center">
<img src="https://github.com/user-attachments/assets/YOUR_SCREENSHOT_FILENAME" width="800" alt="SketchyBar Preview"/>
</p>

---

## 🔍 Overview

A personal **SketchyBar** configuration for **macOS**, designed to work seamlessly with **Aerospace** window manager. Built on Felix Kratz's excellent SbarLua framework, with Tokyo Night theming, custom widgets, and multi-monitor workspace integration.

### ✨ Key Features

| Feature | Description |
| ------- | ---------- |
| 🌙 **Tokyo Night Theme** | Beautiful dark colorscheme |
| 🖥️ **Multi-Monitor** | Native Aerospace workspaces |
| 📊 **Rich Widgets** | WiFi, battery, CPU, media, weather |
| 🎨 **Custom Icons** | Extended app icon font |
| ✈️ **Aerospace** | Pre-configured `.aerospace.toml` |

---

## 📋 Table of Contents

- [Installation](#-installation)
- [Required Customization](#-required-customization)
- [Configuration Structure](#configuration-structure)
- [Troubleshooting](#troubleshooting)
- [Customization](#customization)
- [Credits](#credits)

---

## 🔧 Installation

### Prerequisites

- **macOS 12+**
- **Homebrew**
- **Aerospace**
- **Git**

### Setup

```bash
git clone https://github.com/NoamFav/sketchybar.git
cd sketchybar
chmod +x install.sh
./install.sh
```

The installer handles everything — dependencies, fonts, configuration, and restart.

---

## ⚙️ Required Customization

> **Note:** Some settings are personalized. Update these for your setup.

### Multi-Monitor Setup

The workspace config in `aerospace_workspaces.lua` uses a 3-monitor layout:

```lua
local WORKSPACE_LAYOUT = {
	{ display = 3, workspaces = { "1", "2", "3", "4", "5", "6", "7", "8", "9" } }, -- left
	{ display = 1, workspaces = { "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P" } }, -- middle
	{ display = 2, workspaces = { "A", "S", "D", "F", "G", "Z", "X", "C", "V", "B" } }, -- right
}
```

**Update for your setup:**
- Change `display` numbers for your monitors
- Update workspace names to match your Aerospace config

### WiFi Interface

Find your interface:
```bash
networksetup -listallhardwareports
```
Update `items/wifi.lua` with your device (e.g., `en0`).

### Weather Location

Update location in `items/weather.lua`.

---

## 📁 Configuration Structure

```
~/.config/sketchybar/
├── sketchybarrc              # Entry point
├── colors.lua               # Tokyo Night colors
├── settings.lua            # Global settings
├── .aerospace.toml         # Aerospace config
└── items/
    ├── aerospace_workspaces.lua
    ├── wifi.lua
    ├── battery.lua
    ├── cpu.lua
    ├── weather.lua
    └── ...
```

---

## 🔧 Troubleshooting

| Issue | Solution |
| ----- | -------- |
| Workspaces not showing | Update `WORKSPACE_LAYOUT` |
| WiFi widget broken | Update interface in `wifi.lua` |
| Font issues | Run `fc-cache -f` |
| Permissions | Grant accessibility access |

---

## 🎨 Customization

| Change | File |
| ------- | ----- |
| Colors | `colors.lua` |
| Fonts | `settings.lua` |
| Widget behavior | `items/*.lua` |

---

## 🙏 Credits

- **[FelixKratz](https://github.com/FelixKratz)** — SketchyBar, SbarLua, and original dotfiles
- **[kvndrsslr](https://github.com/kvndrsslr)** — sketchybar-app-font
- **[Tokyo Night](https://github.com/folke/tokyonight.nvim)** — Color scheme

---

## 📜 License

GPL v3 — see [LICENSE](LICENSE).

---

<div align="center">

**Built with ❤️ on macOS**

_Powered by SketchyBar • Inspired by Tokyo Night • Enhanced with Aerospace_

</div>