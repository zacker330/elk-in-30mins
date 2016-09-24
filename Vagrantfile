# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

  ANSIBLE_RAW_SSH_ARGS = []
  machine_box = "trusty-server-cloudimg-amd64-vagrant-disk1"
  machine_box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"



  config.vm.define "oscadcenter" do |machine|
    machine.vm.box = machine_box
    machine.vm.box_url = machine_box_url
    machine.vm.hostname = "oscadcenter"
    machine.vm.network "private_network", ip: "192.168.4.10"
    # machine.vm.synced_folder "/data/", "/data/"
    machine.vm.provider "virtualbox" do |node|
        node.name = "oscadcenter"
        node.memory = 4048
        node.cpus = 2
    end
   end


end
