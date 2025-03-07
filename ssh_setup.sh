#!/bin/bash

SSH_PORT=$1
SSHD_CONFIG="/etc/ssh/sshd_config"
CUR_SSH_PORT=$(grep -E "^#?Port " $SSHD_CONFIG | awk '{print $2}')


# 1. SSH 포트 변경 (현재 포트와 다를 경우 변경)
if [[ "$CUR_SSH_PORT" != "$SSH_PORT" ]]; then
    sudo sed -i "s/^#\?Port [0-9]\+/Port $SSH_PORT/" $SSHD_CONFIG
    PORT_CHANGED=1
    echo "SSH Port Changed"
else
    PORT_CHANGED=0
fi

# 2. 비밀번호 로그인 금지
if grep -Eq "^PasswordAuthentication no" $SSHD_CONFIG; then
    PASSWD_DISABLE=0
else
    sudo sed -i "s/^#\?PasswordAuthentication .*/PasswordAuthentication no/" $SSHD_CONFIG
    PASSWD_DISABLE=1
    echo "Password Disabled"
fi

# 3. 공개키 로그인 허가
if grep -Eq "^PubkeyAuthentication yes" $SSHD_CONFIG; then
    PUBKEY_ENABLE=0
else
    sudo sed -i "s/^#\?PubkeyAuthentication .*/PubkeyAuthentication yes/" $SSHD_CONFIG
    PUBKEY_ENABLE=1
    echo "Pubkey Enabled"
fi

# 4. 설정 변경된 경우에 한해, SSH 재시작
if [[ $PORT_CHANGED -eq 1 || $PASSWD_DISABLE -eq 1 || $PUBKEY_ENABLE -eq 1 ]]; then
    sudo systemctl restart ssh
    echo "SSH Config changed"
else
    echo "Nothing has been changed"
fi