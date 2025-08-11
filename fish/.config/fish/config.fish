# Environment Variables
set -gx MANPAGER 'nvim +Man!'
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx VISUAL nvim
set -gx EDITOR nvim
set -gx NVIMCONF "$HOME/dotfiles/nvim/.config/nvim"
set -gx SCRIPTS "$HOME/scripts"
set -gx DOTFILES "$HOME/dotfiles"
set -gx OE "$HOME/OE"
set -gx HOMEBREW_CASK_OPTS "--no-quarantine"
set -gx BUN_INSTALL "$HOME/.bun"

# PATH additions
fish_add_path $HOME/.local/bin
fish_add_path /opt/homebrew/opt/postgresql@16/bin
fish_add_path $BUN_INSTALL/bin
fish_add_path $HOME/.local/share/bob/nvim-bin
fish_add_path /Users/jeff/.claude/local

# Aliases
alias vim nvim
alias ls "eza -lh"
alias la "eza -lha" 
alias tree "eza -lh --tree"
alias dc "docker ps --format 'table {{.ID}}\t{{.CreatedAt}}\t{{.Status}}\t{{.Names}}'"
alias run "mprocs fe be"
alias fp "ps au | fzf"
alias st speedtest
alias upgrade 'brew update && brew upgrade --greedy && brew upgrade --cask --greedy'

# Initialize starship prompt
if command -v starship >/dev/null
    starship init fish | source
end

# Add cargo to PATH (fish handles PATH differently than bash)
if test -d "$HOME/.cargo/bin"
    fish_add_path $HOME/.cargo/bin
end

# Bun completions - skip bash completion file, fish has different completion system

# NVM setup - use latest version, .nvmrc files will override per project
nvm use latest 2>/dev/null

# Run create_symlinks.sh script
if test -f "$SCRIPTS/create_symlinks.sh"
    bash "$SCRIPTS/create_symlinks.sh"
end