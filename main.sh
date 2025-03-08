#!/bin/bash

# 1. 포트 값 검증
if [ $# -ne 1 ]; then
    echo "How to use: $0 Number"
    exit 1
fi

if ! [[ $1 =~ ^[1-9][0-9]*$ ]]; then
    echo "Use natural number"
    exit 1
fi

if ! [[ $1 =~ ^[1-9][0-9]{3,4}$ ]] || [ $1 -lt 1024 ] || [ $1 -gt 65535 ]; then
    echo "Use natural number between 1024~65535."
    exit 1
fi

# 2. Abort if registered ssh key doesn't exist
AUTHORIZED_KEYS="$HOME/.ssh/authorized_keys"
if [ -f "$AUTHORIZED_KEYS" ]; then
    if [ -s "$AUTHORIZED_KEYS" ]; then
        sudo apt update
        SSH_PORT=$1
        
        chmod +x ./ssh_setup.sh
        chmod +x ./ufw_setup.sh
        chmod +x ./fail2ban_setup.sh
        
        ./ssh_setup.sh $SSH_PORT
        ./ufw_setup.sh $SSH_PORT
        ./fail2ban_setup.sh $SSH_PORT
    fi
else
    echo "No registrted pubkey detected"
fi