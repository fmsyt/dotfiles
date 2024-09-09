function ls --wraps ls

    if  [ (uname) = "Darwin" ]
        command ls $argv
        return
    end

    set -l ls_ignores 'ntuser.*' 'NTUSER.*' 'Thumbs.db' 'thumbs.db' 'desktop.ini'

    # set IFS ","; alias ls "ls --human-readable --group-directories-first --color=auto --ignore={${ls_ignores[*]}}"
    set -l ig (string join ',' $ls_ignores)
    set -l igr (string replace -a \* \\\* $ig)

    command ls --human-readable --group-directories-first --color=auto --ignore={$ig} $argv
end
