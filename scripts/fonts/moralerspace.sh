#!/bin/bash

tmp_dir=$(mktemp -d)
curl -s https://api.github.com/repos/yuru7/moralerspace/releases/latest > $tmp_dir/releases.json

echo $tmp_dir/releases.json

assets=$(cat $tmp_dir/releases.json | jq -r .assets[].name)
if [ -z "$assets" ]; then
  echo "No assets found"
  exit 1
fi

select_asset() {
  select file in $@; do
    echo $file
    break
  done
}

file_name=""
if [ $(echo $assets | wc -w) -eq 1 ]; then
  file_name=$assets
else
  echo -e "Select the asset to download: \033[0;32m"
  until [ -n "$file_name" ]; do
    file_name=$(select_asset $assets)
  done
fi

echo -e "Selected: \033[0;32m$file_name\033[0;39m"

cat $tmp_dir/releases.json | jq -r .assets[].name | grep -n "$file_name"
index=$(cat $tmp_dir/releases.json | jq -r .assets[].name | grep -n "$file_name" | awk -F ':' '{print $1}')
latest_url=$(cat $tmp_dir/releases.json | jq -r .assets[$index-1].browser_download_url)

echo -e "Downloading from: \033[0;32m$latest_url\033[0;39m"
curl -s -L -o $tmp_dir/$file_name $latest_url

mkdir -p $HOME/.fonts/moralerspace

echo -e "Unzipping to: \033[0;32m$HOME/.fonts/moralerspace/\033[0;39m"
unzip $tmp_dir/$file_name -d $HOME/.fonts/moralerspace/

command fc-cache -f -v

rm -rf $tmp_dir
