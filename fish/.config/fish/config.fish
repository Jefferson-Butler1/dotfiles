# Detect OS and source OS-specific configuration
switch (uname)
    case Darwin
        source $HOME/.config/fish/config.darwin.fish
    case Linux
        source $HOME/.config/fish/config.linux.fish
end

# Environment Variables
set -gx MANPAGER 'nvim +Man!'
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx VISUAL nvim
set -gx EDITOR nvim
set -gx NVIMCONF "$HOME/dotfiles/nvim/.config/nvim"
set -gx SCRIPTS "$HOME/scripts"
set -gx DOTFILES "$HOME/dotfiles"
set -gx OE "$HOME/OE"
set -gx BUN_INSTALL "$HOME/.bun"
set -gx FISH "$HOME/.config/fish"

# PATH additions (cross-platform)
fish_add_path $HOME/.local/bin
fish_add_path $BUN_INSTALL/bin
fish_add_path $HOME/.local/share/bob/nvim-bin
fish_add_path $HOME/.claude/local

# Aliases
alias vim nvim
alias sp "ssh-picker"
alias dc "docker ps --format 'table {{.ID}}\t{{.CreatedAt}}\t{{.Status}}\t{{.Names}}'"
alias fp "ps au | fzf"
alias st speedtest
alias weather "curl https://wttr.in/48.69,-122.19"
alias source_fish "source ~/.config/fish/config.fish"
alias tm 'tmux-sessionizer'

# Initialize starship prompt
if command -v starship >/dev/null
    starship init fish | source
end

if test -d "$HOME/.cargo/bin"
    fish_add_path $HOME/.cargo/bin
end

# fnm (Fast Node Manager) - .nvmrc/.node-version files will set version per project
if command -v fnm >/dev/null
    fnm env --use-on-cd | source
end

# Run create_symlinks.sh script
if test -f "$SCRIPTS/create_symlinks.sh"
    bash "$SCRIPTS/create_symlinks.sh"
end
