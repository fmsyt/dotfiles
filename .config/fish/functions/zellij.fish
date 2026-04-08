function zellij --wrap zellij

    set -l ignores [help --help -h]
    if contains -- $argv $ignores
        command zellij $argv
        return
    end

    set -l subcommands (string match -rv '^-.*' -- $argv)
    set -l attach_subcommands attach a

    if test (count $subcommands) -eq 0
        or contains -- $subcommands $attach_subcommands

        if test -n "$WEZTERM_UNIX_SOCKET"
            printf "\033]1337;SetUserVar=%s=%s\007" IN_ZELLIJ (echo -n 1 | base64)
        end
    end

    command zellij $argv

    # exit or detach zellij, unset the variable
    printf "\033]1337;SetUserVar=%s=%s\007" IN_ZELLIJ (echo -n 0 | base64)
end
