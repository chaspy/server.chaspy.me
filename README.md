# servers.chaspy.me

1. Create 2 VPS at conoha(Ubuntu 18.04)
2. Update `~/.ssh/config` (see `config.sample`)
3. Add A recort to Route53 for server.chaspy.me
4. Send initial script
  - `scp script/* root@server.chaspy.me:/root/`
  - `scp script/* root@<bench server IP>:/root/`
5. Exec init script
  - `ssh root@server.chaspy.me ./init.sh`
  - `ssh root@<bench server IP> ./init.sh`
6. Exec script for Let"s Encrypt
  - `ssh conoha`
  - `sudo su`
  - `cd && ./letsencrypt.sh``
7. Update `hosts`
8. ansible-playbook -i hosts site.yml

