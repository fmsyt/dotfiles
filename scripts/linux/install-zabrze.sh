#!/bin/sh

current_version="0.0.0"

# check if already installed
if [ -x "$(command -v zabrze)" ]; then
    # zabrze 0.4.0
    v=$(zabrze --version)
    current_version=$(echo $v | awk '{print $2}')

    unset v
fi

latest_url=$(curl -w "%{redirect_url}" -s -o /dev/null https://github.com/Ryooooooga/zabrze/releases/latest)
# => https://github.com/microsoft/cascadia-code/releases/tag/v3.1.1

tag=$(echo $latest_url | awk -F '/' '{print $NF}')
tag_without_v=$(echo $tag | sed 's/v//')

if [ "$current_version" = "$tag_without_v" ]; then
    echo "Already up-to-date"
    exit 0
fi

arch=$(uname -m)
latest_url=$(echo $latest_url | sed 's/tag/download/')

tmp_dir=$(mktemp -d)

file_name=zabrze-$tag-$arch-unknown-linux-gnu.tar.gz

command wget -P $tmp_dir/ $latest_url/$file_name

command mkdir -p $HOME/.local/bin
command tar -C $HOME/.local/bin -xzf $tmp_dir/$file_name

command rm -rf $tmp_dir
