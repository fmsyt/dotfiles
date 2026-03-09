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

export AQUA_ROOT_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua"
export AQUA_GLOBAL_CONFIG="$HOME/.config/aquaproj-aqua/aqua.yaml"

if conmand -v aqua >/dev/null 2>&1; then
  source <(aqua completion bash)
fi
