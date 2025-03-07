#!/bin/bash

# 1. 포트 값 검증
if [$# -ne 1 ]; then
    echo "사용법: $0 <자연수>"
    exit 1
fi

if ![[ $1 =~ ^[1-9][0-9]*$ ]]; then
    echo "오류: 자연수를 입력하세요."
    exit 1
fi

if ![[ $1 =~ ^[1-9][0-9]{3,4}$ ]] || [ $1 -lt 1024 ] || [ $1 -gt 65535 ]; then
    echo "오류: 1024~65535 범위의 유효한 포트 번호를 입력하세요."
    exit 1
fi


# 2. 등록된 공개키 없으면 abort
AUTHORIZED_KEYS="$HOME/.ssh/authorized_keys"
if [ -f "$AUTHORIZED_KEYS" ]; then
    if [-s "$AUTHORIZED_KEYS"]; then
        # 공개키 등록 확인, 계속
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
    echo "등록된 키 파일 없음"
fi

