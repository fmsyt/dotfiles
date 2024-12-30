alias sudo='sudo -E '

ls_ignores=(
    'ntuser.*'
    'NTUSER.*'
    'Thumbs.db'
    'thumbs.db'
    'desktop.ini'
)

if command -v eza >/dev/null 2>&1; then

    IFS="|"; declare opts="-I \"${ls_ignores[*]}\""

    alias eza="eza --icons $opts"

    alias ll='eza -gl'
    alias la='eza -agl'
    alias l='eza'

elif command -v exa >/dev/null 2>&1; then

    IFS="|"; declare opts="-I \"${ls_ignores[*]}\""

    if test $HOME/.config/sh/scripts/exa-supported-icons.sh; then
        opts="$opts --icons"
    fi

    alias exa="exa $opts"

    alias ll='exa -gl'
    alias la='exa -agl'
    alias l='exa'

else
    ls_options=('--human-readable' '--group-directories-first' '--color=auto')
    ls_options_confirm=()

    for opt in "${ls_options[@]}"; do
        if ls $opt >/dev/null 2>&1; then
            ls_options_confirm+=("$opt")
        fi
    done

    if type ls --ignore >/dev/null 2>&1; then
        IFS=","; ls_options_confirm+="--ignore={{ls_ignores[*]//\*/\\\*}}"
    fi

    IFS=" "; alias ls="ls ${ls_options_confirm[*]}"

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

alias ip='ip -color'


if type bat >/dev/null 2>&1; then
    alias cat='bat -p'
elif command -v batcat >/dev/null 2>&1; then
    alias cat='batcat -p'
fi
