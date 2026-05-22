#!/bin/bash

set -e

function help() {
  echo "Usage: $0"
  echo "  -h, --help : Show help"
  echo "  --reinstall: Reinstall xremap"
  exit 1
}

REINSTALL=false

# parse arguments
for OPT in "$@"; do
  case "$OPT" in
  '-h' | '--help')
    help
    exit 1
    ;;
  '--reinstall')
    REINSTALL=true
    shift 1
    ;;
  *)
    help
    exit 1
    ;;
  esac
done

function install_xremap() {
  if [ ! -d /usr/local/bin ]; then
    sudo mkdir -p /usr/local/bin
  fi

  # install releases from https://github.com/xremap/xremap

  # select in x11, wayland, gnome, kde, sway, wlroots, hyprland

  # echo "Current environment: $(env | grep XDG_SESSION_TYPE)"
  echo "Current Desktop: $(env | grep XDG_CURRENT_DESKTOP)"
  echo
  echo "Select your environment"
  echo "1) x11"
  echo "2) Gnome Wayland"
  echo "3) KDE Wayland"
  echo "4) Sway"
  echo "5) wlroots"
  echo "6) hyprland"
  echo
  read -p "Select number: " ENV

  case $ENV in
  1)
    feature="x11"
    ;;
  2)
    feature="gnome"
    ;;
  3)
    feature="kde"
    ;;
  4)
    feature="sway"
    ;;
  5)
    feature="wlroots"
    ;;
  6)
    feature="hypr"
    ;;
  *)
    echo "Invalid number"
    exit 1
    ;;
  esac

  asset_name="xremap-linux-$(uname -m)-${feature}.zip"

  latest_url=$(curl -s https://api.github.com/repos/xremap/xremap/releases/latest | jq -r ".assets[] | select(.name == \"${asset_name}\") | .browser_download_url")

  if [ -z "$latest_url" ]; then
    echo "Failed to get latest release"
    exit 1
  fi

  curl -L -o "/tmp/${asset_name}" "$latest_url"
  unzip "/tmp/${asset_name}" -d /tmp
  sudo mv /tmp/xremap /usr/local/bin
  sudo chmod +x /usr/local/bin/xremap
  rm "/tmp/${asset_name}"
  rm -rf /tmp/xremap

  echo "Installed xremap"
}

# install xremap if not installed
if ! command -v xremap &>/dev/null; then
  install_xremap
  REINSTALL=false
fi

if [ "$REINSTALL" = true ]; then
  install_xremap
fi

# make service file
# works background
# reload xremap when xremap.yaml is updated
cat <<EOF >"$HOME/.config/systemd/user/xremap.service"
[Unit]
Description=Xremap
After=default.target

[Service]
ExecStart=/usr/local/bin/xremap --watch=device %h/.config/xremap/keymap.yaml
Restart=always
StandardOutput=journal
StandardError=journal

MemoryHigh=8M
MemoryMax=16M
IPAddressDeny=any

[Install]
WantedBy=default.target
EOF

echo "Installed xremap.service"
