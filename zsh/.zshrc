# NVM configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
export PATH="$NVM_DIR/versions/node/v22.13.1/bin:$PATH"

# Path to your Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"       # REQUIRED FOR MACOS
# export ZSH="/usr/share/oh-my-zsh" # REQUIRED FOR LINUX
export ZSH_CUSTOM=~/.oh-my-zsh/custom
export MANPAGER='nvim +Man!'
export XDG_CONFIG_HOME="$HOME/.config"

# Function to auto-install missing plugins
function ensure_plugin() {
   local plugin_name=$1
   local plugin_path=$ZSH_CUSTOM/plugins/$plugin_name
   # local plugin_path=${ZSH_CUSTOM:-$ZSH/custom}/plugins/$plugin_name
   # local plugin_path="${HOME}/.oh-my-zsh/custom/plugins/${plugin_name}"
   
   if [[ ! -d $plugin_path ]]; then
       echo "Installing $plugin_name..."
       case $plugin_name in
           "zsh-autosuggestions")
               git clone https://github.com/zsh-users/$plugin_name $plugin_path
               ;;
           "zsh-syntax-highlighting")
               git clone https://github.com/zsh-users/$plugin_name $plugin_path
               ;;
           # Template for new plugins:
           # "plugin-name")
           #     git clone https://github.com/username/$plugin_name $plugin_path
           #     ;;
       esac
   fi
}

# Install missing plugins
ensure_plugin "zsh-autosuggestions"
ensure_plugin "zsh-syntax-highlighting"

# Make _ and - interchangeable in completion
HYPHEN_INSENSITIVE="true"

# Update behavior
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 1

# Visual feedback during completion
COMPLETION_WAITING_DOTS="true"

# Speed up Git status checks in large repos
DISABLE_UNTRACKED_FILES_DIRTY="true"

# ISO 8601 timestamps in history
HIST_STAMPS="yyyy-mm-dd"

# Essential plugins
plugins=(
   git
   z
   zsh-autosuggestions
   zsh-syntax-highlighting
   macos
   docker
   timer
   copypath
   web-search
)

ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh

# Function to set terminal title
function set_title() {
    # Set the tab title to the provided string
    echo -ne "\e]1;$@\a"
}

# This runs before each prompt
function precmd() {
    # When no program is running, just show the directory name
    set_title "~${PWD##*/}"
}

# This runs before executing a command
function preexec() {
    # Get the first word of the command (the program name)
    local program=$(echo "$1" | cut -d' ' -f1)
    # Show program and directory
    set_title "$program~${PWD##*/}"
}
DISABLE_AUTO_TITLE="true"

# Basic aliases
export VISUAL=nvim 
export EDITOR=nvim 
alias vim="nvim"
alias ls="eza -lh"
alias la="eza -lha"
alias tree="eza -lh --tree"

export NVIMCONF="$HOME/dotfiles/nvim/.config/nvim"

# make sure all my scripts are available
export SCRIPTS="$HOME/scripts"
export DOTFILES="$HOME/dotfiles"
export OE="$HOME/OE"
export NVIMCONF="$HOME/dotfiles/nvim/.config/nvim"
$SCRIPTS/create_symlinks.sh

export PATH=$HOME/.local/bin:$PATH


# Initialize starship prompt
eval "$(starship init zsh)"

# Enable completion system
autoload -Uz compinit && compinit
alias dc="docker ps --format 'table {{.ID}}\t{{.CreatedAt}}\t{{.Status}}\t{{.Names}}'"
# alias be="cd $OE/.v3/v3-nest; lsof -ti :8080 | xargs kill && yarn install && yarn run dev; popd"
# alias fe="cd $OE/.v3/v3-monorepo; lsof -ti :9191 -o -ti :9090 | xargs kill && nvm use 22.13.1 && yarn install && yarn run all-dev; popd"
alias run="mprocs fe be"

alias fp="ps au | fzf"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
export PATH="/usr/local/opt/postgresql@16/bin:$PATH"
alias st=speedtest
. "$HOME/.cargo/env"
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

alias claude="/Users/jeff/.claude/local/claude"
