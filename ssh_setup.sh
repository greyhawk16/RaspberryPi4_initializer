#!/bin/bash
SSH_PORT=$1
SSHD_CONFIG="/etc/ssh/sshd_config"


# 1. ssh 포트 변경
sudo sed -i "s/^#\?Port [0-9]\+/Port $SSH_PORT/" $SSHD_CONFIG

# 2. 비밀번호 사용 로그인 금지
sudo sed -i "s/^#\?PasswordAuthentication .*/PasswordAuthentication no/" $SSHD_CONFIG

# 3. 공개키 사용 로그인 허가
sudo sed -i "s/^#\?PubkeyAuthentication .*/PubkeyAuthentication yes/" $SSHD_CONFIG

sudo systemctl restart ssh