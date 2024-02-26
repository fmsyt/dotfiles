#!/bin/sh

if type unzip >/dev/null 2>&1; then
  echo "unzip command is installed"
else
  echo "unzip command is not installed"
  exit 1
fi

latest_url=$(curl -w "%{redirect_url}" -s -o /dev/null https://github.com/githubnext/monaspace/releases/latest)
# https://github.com/githubnext/monaspace/releases/tag/v1.000

tag=$(echo $latest_url | awk -F '/' '{print $NF}')
latest_url=$(echo $latest_url | sed 's/tag/download/')

file_name=monaspace-$tag.zip

tmp_dir=$(mktemp -d)

command wget -P $tmp_dir/ $latest_url/$file_name

mkdir -p $HOME/.fonts
command unzip $tmp_dir/$file_name -d $HOME/.fonts/monaspace/

rm -rf $tmp_dir
