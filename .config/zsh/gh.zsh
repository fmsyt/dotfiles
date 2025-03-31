if ! command -v gh &> /dev/null; then
    return
fi

eval "$(gh completion -s zsh)"
