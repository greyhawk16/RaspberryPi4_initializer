#!/bin/bash

SSH_PORT=$1
SSHD_CONFIG="/etc/ssh/sshd_config"
CUR_SSH_PORT=$(grep -E "^#?Port " $SSHD_CONFIG | awk '{print $2}')


# 1. Change ssh port
if [[ "$CUR_SSH_PORT" != "$SSH_PORT" ]]; then
    sudo sed -i "s/^#\?Port [0-9]\+/Port $SSH_PORT/" $SSHD_CONFIG
    PORT_CHANGED=1
    echo "SSH Port Changed"
else
    PORT_CHANGED=0
fi

# 2. Ban password login
if grep -Eq "^PasswordAuthentication no" $SSHD_CONFIG; then
    PASSWD_DISABLE=0
else
    sudo sed -i "s/^#\?PasswordAuthentication .*/PasswordAuthentication no/" $SSHD_CONFIG
    PASSWD_DISABLE=1
    echo "Password Disabled"
fi

# 3. Allow pubkey login
if grep -Eq "^PubkeyAuthentication yes" $SSHD_CONFIG; then
    PUBKEY_ENABLE=0
else
    sudo sed -i "s/^#\?PubkeyAuthentication .*/PubkeyAuthentication yes/" $SSHD_CONFIG
    PUBKEY_ENABLE=1
    echo "Pubkey Enabled"
fi

# 4. Restart only whan ssh configuration has been changed
if [[ $PORT_CHANGED -eq 1 || $PASSWD_DISABLE -eq 1 || $PUBKEY_ENABLE -eq 1 ]]; then
    sudo systemctl restart ssh
    echo "SSH Config changed"
else
    echo "Nothing has been changed"
fi