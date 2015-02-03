# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "chef/centos-6.5"
  config.vm.box_url = "https://atlas.hashicorp.com/chef/centos-6.5"
  config.vm.network "private_network", ip: "192.168.50.50"
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "1024"
  end
  config.vm.provision :shell, :path => "bootstrap.sh"

end
