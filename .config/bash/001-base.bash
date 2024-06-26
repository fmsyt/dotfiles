export PATH="$HOME/.local/bin:$PATH"

for filename in $HOME/.config/sh/*.sh; do
  source $filename
done

function _update_ps1_powerline() {
    PS1="$(~/.local/bin/powerline-shell $?)"
}

export GPG_TTY=$(tty)

if [ "$TERM" != "linux" -a -f ~/.local/bin/powerline-shell ]; then
    PROMPT_COMMAND="_update_ps1_powerline; $PROMPT_COMMAND"
fi

