set -l ls_ignores 'ntuser.*' 'NTUSER.*' 'Thumbs.db' 'thumbs.db' 'desktop.ini'

if type exa >/dev/null 2>&1

    alias ls='exa'

    set -l ig (string join '|' $ls_ignores)
    set -l opts "-I \"$ig\""

    if exa --icons >/dev/null 2>&1
        set opts "$opts --icons"
    end

    alias exa="exa $opts"

    alias ll='exa -l'
    alias la='exa -al'
    alias l='exa'

else
    # set IFS ","; alias ls "ls --human-readable --group-directories-first --color=auto --ignore={${ls_ignores[*]}}"
    set -l ig (string join ',' $ls_ignores)
    echo $ig
    alias ls="ls --human-readable --group-directories-first --color=auto --ignore={$ig}"

    alias ll='ls -lF'
    alias la='ls -AlF'
    alias l='ls -CF'
end

if type nvim >/dev/null 2>&1
    export EDITOR=nvim
    alias svim='EDITOR=nvim sudoedit'
else
    export EDITOR=vim
    alias svim='EDITOR=vim sudoedit'
end

if [ -x /usr/bin/docker ]
    alias d='docker'
    alias de='docker exec -it'

    if docker compose >/dev/null 2>&1
        alias dc='docker compose'
        alias dce='docker compose exec'
        alias dcu='docker compose up -d'
        alias dcub='docker compose up --build -d'
    end
end
