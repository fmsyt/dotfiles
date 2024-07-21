#!/bin/sh

latest_url=$(curl -w "%{redirect_url}" -s -o /dev/null https://github.com/microsoft/cascadia-code/releases/latest)
# => https://github.com/microsoft/cascadia-code/releases/tag/v3.1.1

tag=$(echo $latest_url | awk -F '/' '{print $NF}')
tag_without_v=$(echo $tag | sed 's/v//')
latest_url=$(echo $latest_url | sed 's/tag/download/')

tmp_dir=$(mktemp -d)

file_name=CascadiaCode-$tag_without_v.zip

command wget -P $tmp_dir/ $latest_url/$file_name

command mkdir -p $HOME/.fonts
command unzip $tmp_dir/$file_name -d $HOME/.fonts/CascadiaCode/

command fc-cache -f -v

command rm -rf $tmp_dir
