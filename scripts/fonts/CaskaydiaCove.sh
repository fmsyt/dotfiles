#!/bin/sh

latest_url=$(curl -w "%{redirect_url}" -s -o /dev/null https://github.com/ryanoasis/nerd-fonts/releases/latest)
# => https://github.com/ryanoasis/nerd-fonts/releases/tag/v3.1.1

latest_url=$(echo $latest_url | sed 's/tag/download/')

tmp_dir=$(mktemp -d)

command wget -P $tmp_dir/ $latest_url/CascadiaCode.tar.xz
if [ $? -ne 0 ]; then
  echo "Download failed"
  exit 1
fi

mkdir -p $HOME/.fonts/CaskaydiaCove
command tar Jxfv $tmp_dir/CascadiaCode.tar.xz -C $HOME/.fonts/CaskaydiaCove/

command fc-cache -f -v

rm -rf $tmp_dir
