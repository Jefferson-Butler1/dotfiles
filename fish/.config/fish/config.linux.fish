# Arch Linux-specific Fish configuration

# Linux-specific environment variables
set -gx TMPDIR /tmp

# Linux-specific aliases
alias upgrade 'yay -Syu'
alias pacup 'sudo pacman -Syu'
