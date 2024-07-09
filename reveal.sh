#!/bin/bash
set -ue

SCRIPT_DIR=$(cd $(dirname $0); pwd)

command git secret --version

if [ $? -gt 0 ]; then
    echo "git-secret is not installed. Please install it first."
    exit 1
fi


function post_reveal() {
    echo "Post reveal..."

    SSH_CONFIG_DIR="$HOME/.ssh/shared"
    SSH_CONFIG_FILE="$HOME/.ssh/config"

    chmod 600 $SSH_CONFIG_FILE
    chmod 600 $SSH_CONFIG_DIR/*.conf
    chmod 600 $SSH_CONFIG_DIR/*.pem

    echo "Done."
}


echo "Revealing secrets..."
git secret reveal -P

if [ $? -gt 0 ]; then
    echo "Failed to reveal secrets."
    exit 1
fi

post_reveal
