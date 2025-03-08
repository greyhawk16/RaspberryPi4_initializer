#!/bin/bash
SSH_PORT=$1
JAIL_CONF="/etc/fail2ban/jail.conf"
JAIL_LOCAL="/etc/fail2ban/jail.local"

sudo apt install fail2ban -y

if [[ ! -f "$JAIL_LOCAL" ]]; then
    sudo cp "$JAIL_CONF" "$JAIL_LOCAL"
fi

# modify sshd section at jail.local
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