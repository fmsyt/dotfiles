#!/bin/sh

latest_url=$(curl -w "%{redirect_url}" -s -o /dev/null https://github.com/ryanoasis/nerd-fonts/releases/latest)
# => https://github.com/ryanoasis/nerd-fonts/releases/tag/v3.1.1

latest_url=$(echo $latest_url | sed 's/tag/download/')

rm /tmp/CascadiaCode.tar.xz
command wget -P /tmp/ $latest_url/CascadiaCode.tar.xz

mkdir -p $HOME/.fonts
command tar Jxfv /tmp/CascadiaCode.tar.xz -C $HOME/.fonts/

rm /tmp/CascadiaCode.tar.xz
