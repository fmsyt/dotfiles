function exa --wraps exa
    set -l ls_ignores 'ntuser.*' 'NTUSER.*' 'Thumbs.db' 'thumbs.db' 'desktop.ini'

    set -l ig (string join '|' $ls_ignores)
    set -l opts "-I \"$ig\""

    if exa --icons >/dev/null 2>&1
        set opts "$opts --icons"
    end

    command exa $opts $argv
end
