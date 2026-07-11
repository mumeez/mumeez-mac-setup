# mumeez's macOS Setup

A simple, practical macOS development setup on a **MacBook Air (M5, 2026)** running **macOS Golden Gate**.

## What I Use

| Category | Tools |
|----------|-------|
| **Terminal** | Ghostty (primary), Kitty |
| **Shell** | zsh + Starship prompt + zoxide + fzf |
| **Editor** | Neovim (LazyVim), Doom Emacs |
| **Launcher & WM** | Raycast 2.0 — keybinds, window management, launcher, clipboard, snippets |
| **Local LLMs** | Ollama (Ornith 9B, Phi-4 Mini) |
| **AI Coding** | OpenCode (7 specialized agents), Claude (desktop), Gemini CLI |
| **System Monitor** | Stats (menu bar), btop, cava (audio viz) |
| **File Manager** | yazi |
| **CLI** | bat, eza, fd, ripgrep, tmux, yt-dlp, pandoc, poppler |

## Quick Start

```bash
git clone https://github.com/mumeez/mumeez-mac-setup.git ~/github/mumeez-mac-setup
cd ~/github/mumeez-mac-setup
./scripts/setup.sh
```

## Configs

| File/Dir | Purpose |
|----------|---------|
| `~/.zshrc` | Shell aliases, env vars (`OLLAMA_KEEP_ALIVE=10m`) |
| `~/scripts/ai-stack.sh` | Start/stop/status for Ollama |
| `~/.config/ghostty/` | Terminal config + custom shaders |
| `~/.config/kitty/` | Kitty terminal config |
| `~/.config/nvim/` | Neovim (LazyVim) with Neorg for `.org` files |
| `~/.config/opencode/` | AI coding assistant config |
| `~/.config/starship.toml` | Prompt theme |
| `Brewfile` | All Homebrew packages in one place |

## Notes

My notes live in **[notes-main](https://github.com/mumeez/notes-main)** (private) — organized into `obsidian/` and `org/` subfolders.

## Aliases

| Alias | What it does |
|-------|-------------|
| `ll` | `eza -lh --icons --group-directories-first` |
| `v` | `nvim` |
| `y` | `yazi` |
| `gc` | `gemini` |
| `oc` | `opencode` |
| `ai-start` | Start Ollama |
| `ai-stop` | Stop Ollama |
| `ai-status` | Check Ollama status |

## Brewfile

```bash
brew bundle --file=Brewfile
```
