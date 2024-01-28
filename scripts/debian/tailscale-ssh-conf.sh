#!/bin/sh

sudo sh -c 'cat << EOF > /etc/ssh/sshd_config.d/tailscale.conf
Match Address 100.64.0.0/10
    PasswordAuthentication yes
EOF'
