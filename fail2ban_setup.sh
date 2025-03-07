#!/bin/bash
SSH_PORT=$1
JAIL_CONF="/etc/fail2ban/jail.conf"
JAIL_LOCAL="/etc/fail2ban/jail.local"

# 1. fail2ban 설치
sudo apt install fail2ban -y


# 2. jail.conf 파일의 사본(jail.local) 만들기, jail.local이 이미 있는 경우 무시
if [[ ! -f "$JAIL_LOCAL" ]]; then
    sudo cp "$JAIL_CONF" "$JAIL_LOCAL"
fi

# 3. 사본에서 sshd 설정 부분을 찾아, 제한 설정
sudo bash -c "cat > $JAIL_LOCAL" <<EOF
[sshd]
enabled = true
port = ssh
filter = sshd
logpath = %(sshd_log)s
backend = systemd
banaction = iptables-multiport
maxretry = 3
bantime = 345600
EOF

sudo systemctl restart fail2ban
sudo systemctl enable fail2ban