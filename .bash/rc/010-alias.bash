if type exa >/dev/null 2>&1; then
    ls='exa --icons'

    alias ll='exa -l --icons'
    alias la='exa -al --icons'
    alias l='exa --icons'
else
    alias ls='ls --human-readable --group-directories-first --color=auto --ignore={NTUSER*,ntuser*}'

    alias ll='ls -lF'
    alias la='ls -AlF'
    alias l='ls -CF'
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

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
fi

if [ -x /usr/bin/docker-compose ]; then
    alias dc='docker-compose'
    alias dce='docker-compose exec'
    alias dcu='docker-compose up -d'
    alias dcub='docker-compose up --build -d'
fi
