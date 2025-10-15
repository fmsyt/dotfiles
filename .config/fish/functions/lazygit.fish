function lazygit --wrap lazygit
    set -l LG_CONFIG_FILE "$HOME/.config/lazygit/config.yml"

    if command -v delta >/dev/null
        echo "delta found, adding delta config to lazygit"
        set LG_CONFIG_FILE "$HOME/.config/lazygit/config.yml,$HOME/.config/lazygit/config.delta.yml"
    end

    command lazygit --use-config-file="$LG_CONFIG_FILE" $argv
end
