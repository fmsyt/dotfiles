#!/bin/sh

latest_url=$(curl -w "%{redirect_url}" -s -o /dev/null https://github.com/yuru7/HackGen/releases/latest)
# => https://github.com/HackGen/releases/releases/tag/v2.9.0

tag=$(echo $latest_url | awk -F '/' '{print $NF}')
latest_url=$(echo $latest_url | sed 's/tag/download/')

tmp_dir=$(mktemp -d)

font_name=HackGen
file_name=${font_name}_${tag}.zip

command wget -P $tmp_dir/ $latest_url/$file_name

command mkdir -p $HOME/.fonts
command unzip $tmp_dir/$file_name -d $HOME/.fonts/$font_name/

command fc-cache -f -v

command rm -rf $tmp_dir

