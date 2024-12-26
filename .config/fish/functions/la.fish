function la

    set -l ls_ignores 'ntuser.*' 'NTUSER.*' 'Thumbs.db' 'thumbs.db' 'desktop.ini'

    set -l ig (string join '|' $ls_ignores)
    set -l opts "-I \"$ig\""

    if command -v eza > /dev/null 2>&1
        command eza --icons -agl $opts $argv
        return

    else if command -v exa > /dev/null 2>&1
        if test "$DOTFILES_DIR/scripts/linux/utils/exa-supported-icons.sh"
            command exa --icons -agl $opts $argv
        else
            command exa -agl $opts $argv
        end
        return
    end

    command ls -AlF
end
