# Mumeez's macOS Setup

A comprehensive, production-ready macOS configuration for power users who want a highly customized terminal-driven workflow with AI integration, window management, and a beautiful status bar.

> **Note**: This is a macOS-specific setup. For Linux configurations, see my [dotfiles-latest](https://github.com/linkarzu/dotfiles-latest) repository.

---

## Table of Contents

- [Overview](#overview)
- [Requirements](#requirements)
- [Quick Start](#quick-start)
- [What's Included](#whats-included)
  - [Shell & Terminal](#shell--terminal)
  - [Window Management](#window-management)
  - [App Launcher](#app-launcher)
  - [Status Bar](#status-bar)
  - [Editors](#editors)
  - [AI & LLM Tools](#ai--llm-tools)
  - [CLI Utilities](#cli-utilities)
- [Manual Setup Steps](#manual-setup-steps)
- [Keybindings Overview](#keybindings-overview)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)
- [Credits](#credits)

---

## Overview

This repository contains my complete macOS development environment, including:

- **Zsh** with Starship prompt, zoxide, and fuzzy finding
- **AeroSpace** tiling window manager with vim-style keybindings
- **SketchyBar** status bar with custom plugins
- **Raycast** for app launching, window management, and keyboard shortcuts
- **Neovim** (LazyVim) and **Doom Emacs** configurations
- **AI/LLM integration** via Ollama, OpenCode, and MCP servers
- **Custom workflows** via Raycast extensions

This setup is heavily inspired by the [dotfiles-latest](https://github.com/linkarzu/dotfiles-latest) repository and follows best practices for macOS ricing and customization.

---

## Requirements

| Requirement | Description |
|-------------|-------------|
| **macOS** | Tested on macOS Sonoma (14+) |
| **Apple Silicon** | M1/M2/M3 Mac (Intel support possible with minor changes) |
| **Homebrew** | Package manager (required) |
| **Shell** | zsh (default on macOS) |

---

## Quick Start

```bash
# 1. Clone this repository
git clone https://github.com/YOUR_USERNAME/mumeez-mac-setup.git ~/github/current-mac-setup

# 2. Run the setup script
cd ~/github/current-mac-setup
chmod +x scripts/setup.sh
./scripts/setup.sh
```

The setup script will:
- Install all Homebrew packages from the Brewfile
- Install Nerd Fonts
- Create symlinks for all configuration files
- Set up MCP (Model Context Protocol) servers

---

## What's Included

### Shell & Terminal

| Tool | Description |
|------|-------------|
| **zsh** | Shell with Oh My Zsh plugins |
| **Starship** | Fast, customizable prompt |
| **eza** | Modern `ls` replacement with icons |
| **zoxide** | Smarter `cd` command |
| **bat** | Cat clone with syntax highlighting |
| **btop** | System monitor (replaces `top`) |
| **fzf** | Fuzzy finder |
| **yazi** | Blazingly fast file manager |

**Terminals**: Kitty, Ghostty

### Window Management

| Tool | Description |
|------|-------------|
| **AeroSpace** | Tiling window manager (primary) |

### App Launcher & Productivity

| Tool | Description |
|------|-------------|
| **Raycast** | App launcher, window management, keyboard shortcuts, and much more |

> **Note**: Raycast is central to my setup - it handles:
> - App launching (replaces Spotlight)
> - Window management (via AeroSpace integration)
> - Custom keyboard shortcuts
> - Clipboard history
> - Snippets
> - AI-powered search
> - And 25+ custom extensions
>
> Raycast stores its configuration internally and doesn't use traditional config files. The extensions I use are stored in `~/.config/raycast/extensions/`.

### Status Bar

| Tool | Description |
|------|-------------|
| **SketchyBar** | Highly customizable status bar |
| **Borders** | Window borders app |

### Editors

| Tool | Description |
|------|-------------|
| **Neovim** (LazyVim) | My primary editor - fully configured with LazyVim |
| **Doom Emacs** | Emacs configuration (located in `~/.config/emacs`) |

### AI & LLM Tools

| Tool | Description |
|------|-------------|
| **Ollama** | Local LLM runtime |
| **OpenCode** | AI coding with MCP servers |
| **Claude** (desktop) | Anthropic's AI assistant |
| **AnythingLLM** | Chat UI for local LLMs |
| **Gemini CLI** | Google's Gemini CLI |

**MCP Servers Configured** (in OpenCode):
- `filesystem` - Local file access
- `github` - GitHub API integration
- `context7` - Real-time documentation
- `exa` - Web search
- `sentry` - Error tracking
- `playwright` - Browser automation

### CLI Utilities

```bash
# Installed via Homebrew
bat, btop, eza, fastfetch, fd, fzf, jq, neovim, node, pnpm
python@3.14, ripgrep, rust, starship, tmux, topgrade, wget
yazi, yt-dlp, zoxide, zsh-autosuggestions, zsh-syntax-highlighting
```

---

## Manual Setup Steps

After running the automated setup, complete these manual steps:

### 1. Grant Permissions

Open these apps and grant the requested permissions:

```bash
open -a "System Settings" # Navigate to Privacy & Security > Accessibility
```

### 2. Enable Login Items

Add these to login items (System Settings > General > Login Items):

- **AeroSpace** - Window manager
- **SketchyBar** - Status bar
- **Raycast** - App launcher and productivity (set as default)

### 3. Configure Raycast

```bash
# Open Raycast
open -a Raycast

# Set Raycast as default launcher:
# System Settings > Keyboard > Keyboard Shortcuts > Spotlight > Change Raycast
```

### 4. Configure AeroSpace

```bash
# Open AeroSpace config
open -a AeroSpace

# Or edit: ~/.config/aerospace/aerospace.toml
```

### 5. Start SketchyBar

```bash
sketchybar
```

### 6. Verify Shell

```bash
source ~/.zshrc
nvim  # Test Neovim opens
```

---

## Keybindings Overview

### AeroSpace (Window Management)

| Key | Action |
|-----|--------|
| `Alt + H/J/K/L` | Focus window (vim-style) |
| `Alt + Shift + H/J/K/L` | Move window |
| `Alt + 1-9` | Switch workspaces |
| `Alt + Shift + 1-9` | Move window to workspace |
| `Alt + Q` | Close window |
| `Alt + F` | Fullscreen |
| `Alt + W` | Toggle floating |
| `Alt + O` | Move workspace to next monitor |
| `Alt + Shift + R` | Reload config |

### Raycast

Raycast handles many keyboard shortcuts. Key ones include:

| Shortcut | Action |
|----------|--------|
| `Cmd + Space` | Open Raycast (replaces Spotlight) |
| `Cmd + Shift + H` | Hide window |
| `Cmd + Shift + Left/Right` | Snap window |

### Zsh Aliases

| Alias | Command |
|-------|---------|
| `ll` | `eza -lh --icons --group-directories-first` |
| `v` | `nvim` |
| `y` | `yazi` |
| `gc` | `gemini` |
| `oc` | `opencode` |
| `confz` | `nvim ~/.zshrc` |
| `reload` | `source ~/.zshrc` |

---

## Customization

### Changing the Theme

SketchyBar uses colors from the linkarzu colorscheme:

```bash
# The colors are sourced from:
~/github/dotfiles-latest/colorscheme/active/active-colorscheme.sh
```

To change colors, edit or replace this file.

### Adding New MCP Servers

Edit `~/.config/opencode/config.toml`:

```toml
[mcp.servers.my-new-server]
command = "npx"
args = ["-y", "@modelcontextprotocol/server-name"]
description = "What it does"
```

### Modifying Keybindings

- **AeroSpace**: Edit `~/.config/aerospace/aerospace.toml`
- **Shell aliases**: Edit `~/.zshrc`
- **Raycast**: Configure via Raycast preferences (Settings > Shortcuts)

---

## Troubleshooting

### Fonts not showing correctly

```bash
# Reinstall fonts
brew reinstall font-jetbrains-mono-nerd-font font-hack-nerd-font

# Clear font cache
fc-cache -fv
```

### AeroSpace not tiling windows

1. Open System Settings > Privacy & Security > Accessibility
2. Add AeroSpace to the list
3. Restart AeroSpace

### SketchyBar not showing

```bash
# Kill and restart
killall sketchybar
sketchybar
```

### Neovim plugins not loading

```bash
# LazyVim should auto-install, but force sync
nvim --headless +Lazy! sync +qa
```

### MCP servers not connecting

```bash
# Check if npx works
npx @modelcontextprotocol/server-filesystem --help

# Check OpenCode logs
open ~/Library/Logs/opencode.log
```

---

## Directory Structure

```
current-mac-setup/
├── .config/              # App configurations
│   ├── aerospace/        # Window manager
│   ├── btop/             # System monitor
│   ├── kitty/            # Terminal config
│   ├── opencode/         # AI assistant config
│   ├── sketchybar/       # Status bar
│   └── topgrade.toml     # System updater config
├── .zshrc                # Shell config
├── .zprofile             # Login shell config
├── Brewfile              # Homebrew packages
├── scripts/
│   └── setup.sh          # Installation script
└── README.md
```

---

## Credits

This setup was heavily inspired by:

- [dotfiles-latest](https://github.com/linkarzu/dotfiles-latest) - Comprehensive dotfiles by linkarzu
- [LazyVim](https://github.com/LazyVim/LazyVim) - Neovim configuration
- [Doom Emacs](https://github.com/doomemacs/doomemacs) - Emacs configuration
- [SketchyBar](https://github.com/FelixKratz/SketchyBar) - Status bar
- [AeroSpace](https://github.com/nikitabobko/AeroSpace) - Window manager

---

## Resources

- [My YouTube Channel](https://youtube.com/) - macOS workflow videos
- [Homebrew Documentation](https://docs.brew.sh)
- [AeroSpace Documentation](https://nikitabobko.github.io/aerospace/)
- [SketchyBar GitHub](https://github.com/FelixKratz/SketchyBar)
- [Raycast](https://raycast.com/)

---

## License

MIT License - Feel free to use this as a starting point for your own setup!

---

<div align="center">
  <sub>Last updated: April 2026</sub>
</div>
