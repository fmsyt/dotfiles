function open

    if ! test -f "$HOME/.config/sh/scripts/open.sh"
        echo "open.sh not found"
        return 1
    end

    command bash $HOME/.config/sh/scripts/open.sh $argv
end
