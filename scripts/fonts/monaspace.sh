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

rm /tmp/$file_name

command wget -P /tmp/ $latest_url/$file_name

mkdir -p $HOME/.fonts
command unzip /tmp/$file_name -d $HOME/.fonts/monaspace/

rm /tmp/$file_name
