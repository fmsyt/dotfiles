alias sudo='sudo -E '

ls_ignores=(
    'ntuser.*'
    'NTUSER.*'
    'Thumbs.db'
    'thumbs.db'
    'desktop.ini'
)

if type exa >/dev/null 2>&1; then

    alias ls='exa'

    IFS="|"; declare opts="-I \"${ls_ignores[*]}\""

    if exa --icons >/dev/null 2>&1; then
        opts="$opts --icons"
    fi

    alias exa="exa $opts"

    alias ll='exa -l'
    alias la='exa -al'
    alias l='exa'

else
    IFS=","; alias ls="ls --human-readable --group-directories-first --color=auto --ignore={${ls_ignores[*]//\*/\\\*}}"

    alias ll='ls -lF'
    alias la='ls -AlF'
    alias l='ls -CF'
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


if type nvim >/dev/null 2>&1; then
    export EDITOR=nvim
    alias svim='EDITOR=nvim sudoedit'
else
    export EDITOR=vim
    alias svim='EDITOR=vim sudoedit'
fi

if [ -x /usr/bin/docker ]; then
    alias d='docker'
    alias de='docker exec -it'

    if type docker compose >/dev/null 2>&1; then
        alias dc='docker compose'
        alias dce='docker compose exec'
        alias dcu='docker compose up -d'
        alias dcub='docker compose up --build -d'
    fi
fi

