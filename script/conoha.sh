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

# let's ecnrypt
# Note: need name resolve
# A Record server.chaspy.me to <IP addr>
wget https://dl.eff.org/certbot-auto
chmod a+x certbot-auto
# https://community.letsencrypt.org/t/unable-to-lock-the-administration-directory-var-lib-dpkg/59168/4
lsof /var/lib/dpkg/lock
./certbot-auto certonly --standalone -d server.chaspy.me
