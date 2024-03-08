#!/bin/bash

# required root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
bootstrap_path=$SCRIPT_DIR/Xsetup-bootstrap.sh

mkdir -p /usr/share/sddm/scripts

# if Xsetup is not exist, create it
if [ ! -f /usr/share/sddm/scripts/Xsetup ]; then
    echo "Xsetup file is not exist, creating..."
    touch /usr/share/sddm/scripts/Xsetup

    echo "#!/bin/bash" > /usr/share/sddm/scripts/Xsetup
fi

# is already appended line, stop script
if grep -q "source $bootstrap_path" /usr/share/sddm/scripts/Xsetup; then
    echo "Xsetup is already appended"
    exit
fi

# append Xsetup-bootstrap.sh to Xsetup
echo "source $bootstrap_path" >> /usr/share/sddm/scripts/Xsetup

