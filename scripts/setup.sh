#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="$HOME/github/current-mac-setup"

echo "============================================"
echo "  Mumeez's macOS Setup Installer"
echo "============================================"
echo ""

if [ ! -d "$INSTALL_DIR" ]; then
    echo "Error: Setup repository not found at $INSTALL_DIR"
    echo "Please clone the repository first:"
    echo "  git clone https://github.com/YOUR_USERNAME/mumeez-mac-setup.git ~/github/current-mac-setup"
    exit 1
fi

echo "This script will set up your Mac with my configuration."
echo "It will install Homebrew packages and create symlinks to configs."
echo ""
read -p "Continue? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

echo ""
echo "==> Step 1: Installing Homebrew packages..."
echo "--------------------------------------------"
if command -v brew &> /dev/null; then
    brew bundle install --file "$INSTALL_DIR/Brewfile"
else
    echo "Homebrew not found! Please install it first:"
    echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi

echo ""
echo "==> Step 2: Installing Nerd Fonts..."
echo "--------------------------------------------"
if command -v brew &> /dev/null; then
    brew install font-jetbrains-mono-nerd-font font-hack-nerd-font font-symbols-only-nerd-font
fi

echo ""
echo "==> Step 3: Creating symlinks for configs..."
echo "--------------------------------------------"

link_config() {
    local src="$1"
    local dest="$2"
    
    if [ -L "$dest" ]; then
        echo "  - $dest (already linked, skipping)"
    elif [ -e "$dest" ]; then
        echo "  - $dest (exists, backing up and linking)"
        mv "$dest" "$dest.backup.$(date +%s)"
        ln -s "$src" "$dest"
    else
        echo "  - $dest"
        ln -s "$src" "$dest"
    fi
}

link_config "$INSTALL_DIR/.zshrc" "$HOME/.zshrc"
link_config "$INSTALL_DIR/.zprofile" "$HOME/.zprofile"

CONFIG_CONFIGS=(
    "aerospace:aerospace.toml"
    "btop:btop.conf"
    "kitty:kitty.conf"
    "opencode:config.toml"
    "sketchybar"
    "topgrade.toml"
)

for item in "${CONFIG_CONFIGS[@]}"; do
    config_name="${item%%:*}"
    file_name="${item##*:}"
    
    src="$INSTALL_DIR/.config/$config_name"
    dest="$HOME/.config/$config_name"
    
    if [ -e "$src" ]; then
        if [ -L "$dest" ]; then
            echo "  - ~/.config/$config_name (already linked)"
        elif [ -e "$dest" ]; then
            echo "  - ~/.config/$config_name (exists, backing up)"
            mv "$dest" "$dest.backup.$(date +%s)"
            ln -s "$src" "$dest"
        else
            echo "  - ~/.config/$config_name"
            mkdir -p "$(dirname "$dest")"
            ln -s "$src" "$dest"
        fi
    fi
done

echo ""
echo "==> Step 4: Installing Node.js MCP packages..."
echo "--------------------------------------------"
if command -v npm &> /dev/null; then
    npm install -g @modelcontextprotocol/server-filesystem @modelcontextprotocol/server-github @modelcontextprotocol/server-playwright 2>/dev/null || true
fi

echo ""
echo "==> Step 5: Enabling services..."
echo "--------------------------------------------"
echo "  Run these manually to enable at login:"
echo "    - AeroSpace: System Settings > Login Items > Add AeroSpace"
echo "    - SketchyBar: Add to login items after testing"
echo "    - Raycast: Install from App Store or direct download, enable from Preferences"
echo ""

echo "============================================"
echo "  Setup Complete!"
echo "============================================"
echo ""
echo "Next steps:"
echo "  1. Log out and log back in (or restart)"
echo "  2. Grant necessary permissions (Accessibility for AeroSpace)"
echo "  3. Open AeroSpace and configure in System Settings > Privacy"
echo "  4. Run 'sketchybar' to start the status bar"
echo "  5. Source your shell: source ~/.zshrc"
echo "  6. Install Raycast and configure extensions"
echo ""
