#!/usr/bin/env fish
#
# Install Fisher, the plugin manager for Fish shell
# see: https://github.com/jorgebucaran/fisher

if ! command -v fish > /dev/null
    echo "Fish shell is not installed. Please install Fish shell first."
    exit 1
end

if [ -f ~/.config/fish/functions/fisher.fish ]
    mv ~/.config/fish/functions/fisher.fish ~/.config/fish/functions/fisher.fish.bak
    echo -e "\e[33mFisher already installed, backing up existing fisher.fish to fisher.fish.bak\e[0m"
end

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
