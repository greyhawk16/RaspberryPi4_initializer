#!/bin/bash
SSH_PORT=$1


# 1. ufw 설치
sudo apt install ufw -y
sudo ufw enable


# 2. ufw 허용 포트(ssh, http, https) 설정
sudo ufw allow 80
sudo ufw allow 443
sudo ufw allow $SSH_PORT   # ssh 포트


# 3. 레이트 리미트 걸기