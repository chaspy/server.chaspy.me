#!/bin/bash
# 
# init script for ConoHa VPS
# Ubuntu 18.04
# exec by root user
set -x

adduser chaspy
gpasswd -a chaspy sudo
mkdir /home/chaspy/.ssh
curl -f https://github.com/chaspy.keys | tee -a /home/chaspy/.ssh/authorized_keys

# change your ~/.ssh/config
# can login `ssh conoha`
#Host <vps ip addr>
#  HostName conoha
#  User chaspy

# allow sudo without password
echo "chaspy ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# forbidden root login
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
systemctl restart ssh

# firewall enable
ufw enable
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp

