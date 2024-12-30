function ll

    set -l ls_ignores 'ntuser.*' 'NTUSER.*' 'Thumbs.db' 'thumbs.db' 'desktop.ini'

    set -l ig (string join '|' $ls_ignores)
    set -l opts "-I \"$ig\""

    if command -v eza > /dev/null 2>&1
        command eza --icons -gl $opts $argv
        return

    else if command -v exa > /dev/null 2>&1
        if test "$DOTFILES_DIR/scripts/linux/utils/exa-supported-icons.sh"
            command exa --icons -gl $opts $argv
        else
            command exa -gl $opts $argv
        end
        return
    end

    command ls -lF
end
