SCRIPT_DIR=$(cd $(dirname $0); pwd)

# $SCRIPT_DIR/antigen.sh
if [ ! -e $SCRIPT_DIR/antigen.sh ]; then
    curl -L git.io/antigen > $SCRIPT_DIR/antigen.sh
fi

source $SCRIPT_DIR/antigen.sh

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle olets/zsh-abbr@main

antigen apply

abbr -S sudo='sudo -E'
abbr -S grep='grep --color=auto'

abbr -S d='docker'
abbr -S dc='docker compose'
abbr -S dcu='docker compose up'
abbr -S dcd='docker compose down'
abbr -S dcr='docker compose run'
abbr -S dce='docker compose exec'
abbr -S dcl='docker compose logs'
abbr -S dcp='docker compose ps'
abbr -S dcub='docker compose up --build'

abbr -S ip='ip -color'

if [ type exa > /dev/null 2>&1 ]; then
    if [ type exa --icon > /dev/null 2>&1 ]; then
        abbr -S exa='exa --icons'
    fi

    abbr -S l='exa'
    abbr -S ls='exa'
    abbr -S ll='exa -gl'
    abbr -S la='exa -agl'

fi

export EDITOR=vim


