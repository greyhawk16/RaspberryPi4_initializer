# RaspberryPi4_initializer
<img src="https://img.shields.io/badge/Language-%23121011?style=for-the-badge"><img src="https://img.shields.io/badge/bash_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white">

<img src="https://img.shields.io/badge/OS-%23121011?style=for-the-badge"><img src="https://img.shields.io/badge/-Raspberry_Pi-C51A4A?style=for-the-badge&logo=Raspberry-Pi"><img src="https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black">


## Description
These scripts set up SSH configuration, ufw, fail2ban to protect your raspberry pi or linux from brute force attacks.


## How to Use
```
git clone https://github.com/greyhawk16/RaspberryPi4_initializer.git
chmod +x ./main.sh
./main.sh port_number_for_ssh
```

### 1) Clone
`git clone https://github.com/greyhawk16/RaspberryPi4_initializer.git`

Clone this repository to your desired location.

### 2) Grant permission
`chmod +x ./main.sh`

Grant permission for `main.sh` to execute.

### 3) Run script
`./main.sh port_number_for_ssh`

Run `./main.sh` with the port number which you want to use for SSH.