if ! command -v starship &>/dev/null; then
    return
fi

eval "$(starship init bash)"

if [ -f /etc/bash_completion ]; then
    eval "$(starship completions bash)"
fi
