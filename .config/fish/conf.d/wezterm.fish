if not command -v wezterm >/dev/null 2>&1
    exit
end

command wezterm shell-completion --shell fish | source
