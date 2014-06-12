# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "reaandrew/debian-wheezy-64"
  config.vm.network "private_network", ip: "192.168.56.2"
  config.vm.synced_folder "../../shared", "/vagrant_hostshare"
  config.vm.provision :shell, :path => "bootstrap.sh"
  #config.proxy.http     = "http://proxy.sdc.hp.com:8080/"
  #config.proxy.https    = "https://proxy.sdc.hp.com:8080/"
  #config.proxy.no_proxy = "localhost,127.0.0.1,.dev.hp.com,esscontrol-npm,*.essdev.local"
end
