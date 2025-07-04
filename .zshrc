# sheldon - Rust package manager
# https://sheldon.cli.rs/
if [ ! -e ~/.local/bin/sheldon ]; then
    curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
        | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin

    command sheldon init --shell zsh
fi

for filename in $HOME/.config/zsh/*.zsh; do
    source $filename
done

autoload -Uz vcs_info
    setopt prompt_subst
    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' stagedstr "%F{green} "
    zstyle ':vcs_info:git:*' unstagedstr "%F{red} "
    zstyle ':vcs_info:*' formats "  %b %F{cyan}%c%u%f"
    zstyle ':vcs_info:*' actionformats '[%b|%a]'
    precmd () { vcs_info }


# プロンプトカスタマイズ
PROMPT='
[%B%F{red}%n@%m%f%b:%F{green}%~%f]%F{cyan}$vcs_info_msg_0_%f
%F{yellow}$%f '

autoload -U compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select

eval "$(sheldon source)"

dotfiles_dir=$(dirname $(readlink "$HOME/.config"))
script_path="$dotfiles_dir/scripts/linux/install-zabrze.sh"
if [ -f "$script_path" ]; then
    zsh "$script_path" > /dev/null
    eval "$(zabrze init --bind-keys)"
fi




if [ -f $HOME/.local/.zshrc ]; then
    source $HOME/.local/.zshrc
fi
