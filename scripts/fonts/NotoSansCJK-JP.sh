#!/bin/sh

set -eu

font_name=NotoSansCJK-JP
font_dir=$HOME/.fonts/$font_name
font_url=https://github.com/googlefonts/noto-cjk/releases/download/Sans2.004/16_NotoSansJP.zip
file_name=$(basename "$font_url")
tmp_dir=$(mktemp -d)

trap 'rm -rf "$tmp_dir"' EXIT

command mkdir -p "$font_dir"
command wget -O "$tmp_dir/$file_name" "$font_url"
command unzip "$tmp_dir/$file_name" -d "$font_dir"

command fc-cache -f -v
