if status is-interactive
    # Commands to run in interactive sessions can go here

    if ! type -q fisher > /dev/null
        set_color green
        echo -e "Fisher is not installed. Please install it to use extensions if you want."
        set_color normal
        echo "see: https://github.com/jorgebucaran/fisher"
        echo

    else
        set -l fish_config_root $HOME/.config/fish
        if [ ! -f $fish_config_root/fish_plugins ]
            touch $fish_config_root/fish_plugins
        end

        diff --new-line-format="%L" --old-line-format="" --unchanged-line-format="" \
            $fish_config_root/fish_plugins $fish_config_root/fish_plugins_shared >> $fish_config_root/fish_plugins
    end
end

