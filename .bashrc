if [ -f $HOME/.local/.bashrc ]; then
    source $HOME/.local/.bashrc
fi

alias ls='command ls --human-readable --group-directories-first --color=auto --ignore={NTUSER*,ntuser*}'

alias ll='ls -lF'
alias la='ls -AlF'
alias l='ls -CF'

if type nvim >/dev/null 2>&1; then
    export EDITOR=nvim
    alias svim='EDITOR=nvim sudoedit'
else
    export EDITOR=vim
    alias svim='EDITOR=vim sudoedit'
fi
