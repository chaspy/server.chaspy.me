#!/bin/bash
# H2O install scriot for ubuntu 18.04
# https://gist.github.com/inductor/e88f99ecd47615573220d32b0b3a6010
apt update && apt upgrade -y && apt autoremove -y
apt -y install locate git cmake build-essential checkinstall autoconf pkg-config libtool python-sphinx wget libcunit1-dev nettle-dev libyaml-dev libuv-dev libssl-dev zlib1g-dev
git clone https://github.com/tatsuhiro-t/wslay.git
git clone https://github.com/h2o/h2o.git
cd wslay/
autoreconf -i
automake
autoconf
./configure
make
make install
ls /usr/local/lib/
cd ../h2o/
cmake -DWITH_BUNDLED_SSL=on .
make
make install

cat << H2O > /lib/systemd/system/h2o.service
[Unit]
Description=H2O the optimized HTTP/1, HTTP/2 server
After=syslog.target network.target remote-fs.target nss-lookup.target

[Service]
Type=forking
PIDFile=/var/run/h2o/h2o.pid
ExecStartPre=/usr/local/bin/h2o -c /etc/h2o/h2o.conf -t
ExecStart=/usr/local/bin/h2o -c /etc/h2o/h2o.conf -m daemon
ExecReload=/bin/kill -s HUP $MAINPID
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target
H2O

cat << H2Oconf > /etc/h2o/h2o.conf
user: nobody
hosts:
  "server.chaspy.me:443":
    listen:
      port: 443
      host: 0.0.0.0
      ssl:
        certificate-file: "/etc/letsencrypt/live/server.chaspy.me/fullchain.pem"
        key-file: "/etc/letsencrypt/live/server.chaspy.me/privkey.pem"
    paths:
      "/":
        file.dir: /var/www/html
  "server.chaspy.me:80":
    listen:
      port: 80
      host: 0.0.0.0
    paths:
      "/":
        file.dir: /var/www/html
access-log: /var/log/h2o/access.log
error-log: /var/log/h2o/error.log
pid-file: /var/run/h2o/h2o.pid
H2Oconf

cat << INDEX > /var/www/html/index.html
<title>server.chaspy.me</title>
welcome servwer.chaspy.me
INDEX

mkdir -p /var/run/h2o
systemctl enable h2o.service
systemctl start h2o
