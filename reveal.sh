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
    SSH_INCLUDE_DIRECTIVE="Include $SSH_CONFIG_DIR/*.conf"
    SSH_CONFIG_FILE="$HOME/.ssh/config"

    if [ -f $SSH_CONFIG_FILE ]; then
        if grep -q "$SSH_INCLUDE_DIRECTIVE" $SSH_CONFIG_FILE; then
            echo "SSH config already includes shared config. Skipping..."
        else
            echo "Adding shared SSH config include directive..."

            # Add first line to the file
            sed -i "1s;^;$SSH_INCLUDE_DIRECTIVE\n;" $SSH_CONFIG_FILE

        fi
    else
        echo "Creating SSH config file..."
        echo $SSH_INCLUDE_DIRECTIVE > $SSH_CONFIG_FILE
    fi

    echo "Setting permissions..."
    chmod 600 $SSH_CONFIG_FILE
    chmod 600 $SSH_CONFIG_DIR/*.conf
    chmod 600 $SSH_CONFIG_DIR/*.pem

    echo "Done."
}


echo "Revealing secrets..."
git secret reveal

if [ $? -gt 0 ]; then
    echo "Failed to reveal secrets."
    exit 1
fi

post_reveal
