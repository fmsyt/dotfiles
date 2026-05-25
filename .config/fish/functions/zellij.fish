function zellij --wrap zellij
    __wezterm_set_user_var IN_ZELLIJ 1

    function _clear --on-event fish_postexec
        __wezterm_set_user_var IN_ZELLIJ 0
    end

    command zellij $argv
end
