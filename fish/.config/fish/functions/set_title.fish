function set_title --on-event fish_prompt
    # Set terminal title to show current directory basename (like your zsh setup)
    printf '\e]0;~%s\a' (basename $PWD)
end