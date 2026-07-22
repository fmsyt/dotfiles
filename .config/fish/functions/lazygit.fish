function lazygit --wrap lazygit
    set -l config_files

    if set -q LG_CONFIG_FILE; and test -n "$LG_CONFIG_FILE"
        set config_files (string split , -- "$LG_CONFIG_FILE")
    else
        set config_files "$HOME/.config/lazygit/config.yml"
    end

    if command -v delta >/dev/null
        set -l delta_config "$HOME/.config/lazygit/config.delta.yml"
        if not contains -- "$delta_config" $config_files
            set -a config_files "$delta_config"
        end
    end

    command lazygit --use-config-file=(string join , -- $config_files) $argv
end
