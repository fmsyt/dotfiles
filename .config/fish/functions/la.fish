function la
    # check if install exa
    if ! command -v exa > /dev/null 2>&1
        ls -AlF
        return
    end

    set -l ls_ignores 'ntuser.*' 'NTUSER.*' 'Thumbs.db' 'thumbs.db' 'desktop.ini'

    set -l ig (string join '|' $ls_ignores)
    set -l opts "-I \"$ig\""

    if test "$DOTFILES_DIR/scripts/linux/utils/exa-supported-icons.sh"
        command exa --icons -agl $opts $argv
    else
        command exa -agl $opts $argv
    end
end
