#!/bin/bash
# let's ecnrypt
# Note: need name resolve
# A Record server.chaspy.me to <IP addr>
wget https://dl.eff.org/certbot-auto
chmod a+x certbot-auto
# https://community.letsencrypt.org/t/unable-to-lock-the-administration-directory-var-lib-dpkg/59168/4
lsof /var/lib/dpkg/lock
./certbot-auto certonly --standalone -d server.chaspy.me

