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
function sign-lrs
    set -l file $argv[1]
    scp $file 100.90.0.100:/tmp/ && ssh -t 100.90.0.100 "snap sign -k lrs-image-key < /tmp/$file" > (string replace -r '\.[^.]+$' '.signed' $file)
end

tms --generate fish | source
complete -c codex -a '(__fish_complete_path)' -d 'file path'

