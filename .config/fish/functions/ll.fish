function ll
    # check if install exa
    if ! command -v exa 
        ls -AlF
        return
    end

    set -l ls_ignores 'ntuser.*' 'NTUSER.*' 'Thumbs.db' 'thumbs.db' 'desktop.ini'

    set -l ig (string join '|' $ls_ignores)
    set -l opts "-I \"$ig\""

    # check if pass $HOME/.config/sh/scripts/exa-supported-icons.sh

    if test $HOME/.config/sh/scripts/exa-supported-icons.sh
        command exa --icons -gl $opts $argv
    else
        command exa -gl $opts $argv
    end
end
