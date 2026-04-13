# --- 1. ENVIRONMENT VARIABLES ---
export EDITOR='nvim'
export VISUAL='nvim'

# --- 2. HOMEBREW SETUP ---
# This ensures your Mac knows where your installed apps are
eval "$(/opt/homebrew/bin/brew shellenv)"

# --- 3. THE "COOL" ALIASES ---
# Replacements for boring standard commands
alias ls='eza --icons --group-directories-first'
alias ll='eza -lh --icons --group-directories-first'
alias cat='bat'
alias cd='zoxide'  # If you installed zoxide
alias top='btop'   # If you installed btop

# Shortcuts for your favorite tools
alias v='nvim'
alias y='yazi'
alias gc='gemini'
alias oc='opencode'
alias confz='nvim ~/.zshrc'
alias reload='source ~/.zshrc'

# --- 4. SHELL POLISH ---
# Initialize Starship prompt (if you installed it)
eval "$(starship init zsh)"

# Set up FZF (Fuzzy Finder) integration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export STARSHIP_CONFIG=~/.config/starship.toml

# Kitty Shell Integration
if [ "$TERM" = "xterm-kitty" ]; then
  alias ssh="kitty +kitten ssh"
fi

# Local Scripts Folder
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"

# Add Syntax Highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Add Autosuggestions (The "remembering" part)
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# opencode
export PATH=/Users/mumeez/.opencode/bin:$PATH
