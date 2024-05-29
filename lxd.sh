#!/bin/bash
snap remove lxd
wget -q -O - https://pkgs.zabbly.com/key.asc | gpg --show-keys --fingerprint
mkdir -p /etc/apt/keyrings/
wget -O /etc/apt/keyrings/zabbly.asc https://pkgs.zabbly.com/key.asc


sh -c 'cat <<EOF > /etc/apt/sources.list.d/zabbly-incus-stable.sources
Enabled: yes
Types: deb
URIs: https://pkgs.zabbly.com/incus/stable
Suites: $(. /etc/os-release && echo ${VERSION_CODENAME})
Components: main
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/zabbly.asc

EOF'
apt update
apt-get install incus

echo "alias lxd='incus admin'" >> /root/.profile
echo "alias lxc='incus'" >> /root/.profile
source /root/.profile
clear
