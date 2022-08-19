function _update_ps1_powerline() {
    PS1="$(~/.local/bin/powerline-shell $?)"
}

if [ "$TERM" != "linux" -a -f ~/.local/bin/powerline-shell ]; then
    PROMPT_COMMAND="_update_ps1_powerline; $PROMPT_COMMAND"
fi

