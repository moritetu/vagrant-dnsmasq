# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'ipaddr'

MYDNS_NAME = "mydns"
MYDNS_IPADDR = "192.168.10.110"
MYDNS_DOMAIN = "localdomain.local"
MYDNS_IPADDR_REVERSE = IPAddr.new(MYDNS_IPADDR).reverse.split(".")[1..-1].join(".")


Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.network :private_network, ip: MYDNS_IPADDR
  config.vm.synced_folder "./", "/vagrant"

  config.vm.hostname = MYDNS_NAME
  config.vm.provider :virtualbox do |vb|
    vb.name = MYDNS_NAME
    vb.memory = 2048
    vb.cpus = 1
  end

  config.vm.provision "shell" do |s|
    s.path = "provision_mydnq.sh"
    s.env = {
      MYDNS_NAME: MYDNS_NAME,
      MYDNS_DOMAIN: MYDNS_DOMAIN,
      MYDNS_IPADDR: MYDNS_IPADDR,
      MYDNS_IPADDR_REVERSE: MYDNS_IPADDR_REVERSE,
      NAMESERVERS: "1.1.1.1 8.8.8.8",
    }
  end

end
