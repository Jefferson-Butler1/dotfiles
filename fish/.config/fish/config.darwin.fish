# macOS-specific Fish configuration

set -gx TMPDIR (getconf DARWIN_USER_TEMP_DIR)
set -gx HOMEBREW_CASK_OPTS "--no-quarantine"

# Homebrew environment
eval (/opt/homebrew/bin/brew shellenv)

# macOS-specific PATH additions
fish_add_path /opt/homebrew/opt/postgresql@16/bin
fish_add_path /Users/jeff/.lmstudio/bin

# macOS-specific aliases
alias upgrade 'brew update && brew upgrade --greedy && brew upgrade --cask --greedy'

tms --generate fish | source
