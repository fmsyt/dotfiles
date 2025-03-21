# sheldon - Rust package manager
# https://sheldon.cli.rs/
if [ ! -e ~/.local/bin/sheldon ]; then
    curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
        | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin

    command sheldon init --shell zsh
fi

eval "$(sheldon source)"

dotfiles_dir=$(dirname $(readlink "$HOME/.config"))
script_path="$dotfiles_dir/scripts/linux/install-zabrze.sh"
if [ -f "$script_path" ]; then
    zsh "$script_path" > /dev/null
    eval "$(zabrze init --bind-keys)"
fi

# abbr g 'git'
# abbr gs 'git status'
# abbr gst 'git status'
# abbr ga 'git add'
# abbr ga. 'git add .'
# abbr gc 'git commit'
# abbr gp 'git push'
# abbr gco 'git checkout'
# 
# abbr d 'docker'
# abbr de 'docker exec -it'
# 
# abbr dc 'docker compose'
# abbr dce 'docker compose exec'
# abbr dcu 'docker compose up -d'
# abbr dcub 'docker compose up --build -d'
# 
