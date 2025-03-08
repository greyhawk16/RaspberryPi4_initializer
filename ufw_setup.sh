#!/bin/bash
SSH_PORT=$1

# 1. install ufw
sudo apt install ufw -y
sudo ufw enable

# 2. Set ports to allow at ufw
sudo ufw allow 80
sudo ufw allow 443
sudo ufw allow $SSH_PORT