function open

    set -l dotfiles_dir (dirname (readlink "$HOME/.config"))
    set -l script_path "$dotfiles_dir/scripts/linux/utils/open.sh"

    if ! test -f "$script_path"
        echo "open.sh not found"
        return 1
    end

    command bash $script_path $argv
end
