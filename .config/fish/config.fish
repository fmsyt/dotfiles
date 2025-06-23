if status is-interactive
    # Commands to run in interactive sessions can go here
end

if ! type -q fisher > /dev/null
    set_color green
    echo -e "Fisher is not installed. Please install it to use extensions if you want."
    set_color normal
    echo "see: https://github.com/jorgebucaran/fisher"
    echo
end
