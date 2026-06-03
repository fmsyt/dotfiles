#!/bin/bash

segment=$(lsusb | grep "Nape Pro" | awk '{print $6}')

vendor=$(echo "$segment" | cut -d: -f1)
product=$(echo "$segment" | cut -d: -f2)
uid=$(id -u)

sudo tee /etc/udev/rules.d/99-nape-pro.rules <<EOF
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="$vendor", ATTRS{idProduct}=="$product", MODE="660", GROUP="$uid"
EOF

sudo udevadm control --reload-rules
sudo udevadm trigger
