if not command -v wezterm >/dev/null 2>&1
    exit
end

if set -q WEZTERM_UNIX_SOCKET
    alias imgcat 'wezterm imgcat'
    abbr icat imgcat
end

command wezterm shell-completion --shell fish | source
