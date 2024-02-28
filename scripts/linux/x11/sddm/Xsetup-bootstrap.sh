#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for file in $SCRIPT_DIR/Xsetup.conf.d/*.sh; do
  if [ -f $file ]; then
    source $file
  fi
done
