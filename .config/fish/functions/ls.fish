function ls --wraps ls
    set -l ls_ignores 'ntuser.*' 'NTUSER.*' 'Thumbs.db' 'thumbs.db' 'desktop.ini'

    # set IFS ","; alias ls "ls --human-readable --group-directories-first --color=auto --ignore={${ls_ignores[*]}}"
    set -l ig (string join ',' $ls_ignores)
    set -l igr (string replace -a \* \\\* $ig)

    command ls --human-readable --group-directories-first --color=auto --ignore={$ig} $argv

    alias ll='ls -lF'
    alias la='ls -AlF'
    alias l='ls -CF'
end
