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
set -gx FISH "$HOME/.config/fish"
set -gx COMPLETE fish tms | source
set -gx CLAUDE_OAUTH_TOKEN_2025_9_3 "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"

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
alias sp "ssh-picker"
alias dc "docker ps --format 'table {{.ID}}\t{{.CreatedAt}}\t{{.Status}}\t{{.Names}}'"
alias run "mprocs fe be"
alias fp "ps au | fzf"
alias st speedtest
alias weather "curl wttr.in/mazama?u1FnQt"
alias source_fish "source ~/.config/fish/config.fish"
alias source_zsh "source ~/.zshrc"
alias source_bash "source ~/.bashrc"
alias upgrade 'brew update && brew upgrade --greedy && brew upgrade --cask --greedy'
alias tm 'tmux-sessionizer'

# Initialize starship prompt
if command -v starship >/dev/null
    starship init fish | source
end

# Add cargo to PATH (fish handles PATH differently than bash)
if test -d "$HOME/.cargo/bin"
    fish_add_path $HOME/.cargo/bin
end

# Bun completions - skip bash completion file, fish has different completion system

# NVM setup - .nvmrc files will set version per project
# nvm use latest 2>/dev/null

# Run create_symlinks.sh script
if test -f "$SCRIPTS/create_symlinks.sh"
    bash "$SCRIPTS/create_symlinks.sh"
end
eval (/opt/homebrew/bin/brew shellenv)

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/jeff/.lmstudio/bin
# End of LM Studio CLI section
zoxide init fish | source
