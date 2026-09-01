if status is-interactive
    # Commands to run in interactive sessions can go here

    if ! type -q fisher >/dev/null
        set_color green
        echo -e "Fisher is not installed. Please install it to use extensions if you want."
        set_color normal
        echo "see: https://github.com/jorgebucaran/fisher"
        echo

    else
        set -l fish_config_root $HOME/.config/fish
        if test ! -f $fish_config_root/fish_plugins
            or test (wc -c $fish_config_root/fish_plugins | awk '{print $1}') -eq 0
            command cp $fish_config_root/fish_plugins_shared $fish_config_root/fish_plugins
        else
            command awk 'NR==FNR{a[$0]; next} !($0 in a)' \
                $fish_config_root/fish_plugins $fish_config_root/fish_plugins_shared >>$fish_config_root/fish_plugins
        end
    end
end

# vim: set ts=4 sw=4 sts=4 et:
