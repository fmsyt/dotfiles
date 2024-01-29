function open

    if ! test -f $DOTFILES_DIR"/scripts/open.sh"
        echo "open.sh not found"
        return 1
    end

    command bash $DOTFILES_DIR"/scripts/open.sh" $argv
end
