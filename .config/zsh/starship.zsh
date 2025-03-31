if ! command -v starship &>/dev/null; then
    return
fi

eval "$(starship init zsh)"

if [ -f /etc/bash_completion ]; then
    eval "$(starship completions zsh)"
fi
