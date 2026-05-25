function tmux --wrap tmux
    __wezterm_set_user_var IN_TMUX 1

    function _clear --on-event fish_postexec
        __wezterm_set_user_var IN_TMUX 0
    end

    command tmux $argv
end
