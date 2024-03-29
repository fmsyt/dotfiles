function exa --wraps exa
    set -l ls_ignores 'ntuser.*' 'NTUSER.*' 'Thumbs.db' 'thumbs.db' 'desktop.ini'

    set -l ig (string join '|' $ls_ignores)
    set -l opts "-I \"$ig\""

    eval (which exa) --icons > /dev/null 2>&1
    if [ $status -eq 0 ]
        command exa --icons $opts $argv
    else
        command exa $opts $argv
    end

end
