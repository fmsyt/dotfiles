if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
fi

if [ -f /etc/bash_completion ]; then
    eval "$(starship completions bash)"
fi
