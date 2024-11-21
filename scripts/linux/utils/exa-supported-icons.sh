#!/bin/sh

required_version="v0.9.0"
current_version=$(command exa -v | awk 'NR==2' | awk '{print $1}')

if [ "$(printf '%s\n' "$required_version" "$current_version" | sort -V | head -n 1)" = "$required_version" ]; then
  exit 0
fi

exit 1
