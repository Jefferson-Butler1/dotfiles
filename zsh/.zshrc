# Path to your Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Function to auto-install missing plugins
function ensure_plugin() {
   local plugin_name=$1
   local plugin_path=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$plugin_name
   
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

# Basic aliases
alias vim="nvim"
export NVIMCONF="$HOME/dotfiles/nvim/.config/nvim"

# make sure all my scripts are available
export SCRIPTS="$HOME/scripts"
$SCRIPTS/create_symlinks.sh

export PATH=$HOME/.local/bin:$PATH

# NVM configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Initialize starship prompt
eval "$(starship init zsh)"

# Enable completion system
autoload -Uz compinit && compinit
