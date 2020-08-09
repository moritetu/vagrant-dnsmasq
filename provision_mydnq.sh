#!/usr/bin/env bash
#
# provision mydns
#
set -eu

# Download Mustache
if ! command -v mo &> /dev/null; then
  curl -sSL https://git.io/get-mo -o mo
  chmod +x mo
  sudo mv mo /usr/bin/
fi

#yum update -y
yum install -y dnsmasq bind-utils
systemctl stop dnsmasq

# Donot make network manager overwrite resolv.conf
(
  # sudo nmcli c modify "System eth0" ipv4.ignore-auto-dns yes ipv6.ignore-auto-dns yes
  cd /etc/sysconfig/network-scripts/
  /bin/cp ifcfg-eth0 ifcfg-eth0.bak
  sed "/PEERDNS=/d" ifcfg-eth0.bak > ifcfg-eth0.tmp
  echo "PEERDNS=no" >> ifcfg-eth0.tmp
  /bin/mv ifcfg-eth0.tmp ifcfg-eth0

  cd /etc/NetworkManager/
  /bin/cp NetworkManager.conf NetworkManager.conf.bak
  sed "/dns=/d;s/\[main\]/\[main\]\ndns=none/" NetworkManager.conf.bak > NetworkManager.conf.tmp
  /bin/mv NetworkManager.conf.tmp NetworkManager.conf
)


# Make configuration files with bash mustache
mo /vagrant/templates/mydns.conf.mo > /etc/dnsmasq.d/mydns.conf
mo /vagrant/templates/resolv.conf.mo > /etc/resolv.conf
mo /vagrant/templates/hosts.mo > /etc/hosts
mo /vagrant/templates/hosts-dnsmasq.mo > /etc/hosts-dnsmasq
export _NAMESERVERS=( $NAMESERVERS )
. /usr/bin/mo
mo /vagrant/templates/resolv_dnsmasq.conf.mo > /etc/resolv_dnsmasq.conf

systemctl enable dnsmasq
systemctl restart dnsmasq
