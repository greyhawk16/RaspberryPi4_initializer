#!/bin/bash
SSH_PORT=$1
SSHD_CONFIG="/etc/ssh/sshd_config"


# 1. ssh 포트 변경
# 현재의 포트 번호 확인 후, 변경(설정파일에 값 쓰인 방식 다름)
sudo sed -i "s/^#\?Port [0-9]\+/Port $SSH_PORT/" $SSHD_CONFIG

# 2. 비밀번호 사용 로그인 금지
# 이미 금지되었다면 무시하고, 넘어가기
sudo sed -i "s/^#\?PasswordAuthentication .*/PasswordAuthentication no/" $SSHD_CONFIG

# 3. 공개키 사용 로그인 허가
# 이미 금지되었다면 무시하고, 넘어가기
sudo sed -i "s/^#\?PubkeyAuthentication .*/PubkeyAuthentication yes/" $SSHD_CONFIG

# 4. 설정을 변경했는 지 확인하고, 변경한 경우에 한하여 재시작ㄱㄱ
sudo systemctl restart ssh