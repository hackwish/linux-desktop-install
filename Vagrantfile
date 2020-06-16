# -*- mode: ruby -*-
# vi: set ft=ruby :

## == required plugins and params == ##
# vagrant plugin install vagrant-hosts
# vagrant plugin install vagrant-cachier
# gem install fog
##

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.box_url = "ubuntu/focal64"
  config.ssh.insert_key = false
  config.vbguest.auto_update = false
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.auto_detect = true
  end


  config.vm.provider :virtualbox do |v|
    # v.gui = true
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--memory", 2048]
    v.customize ["modifyvm", :id, "--cpus", 2]
  end


  #ANSIBLE
  config.vm.define "desktop" do |master|
    master.vm.hostname = "desktop01.bydefault-cl.test"
    master.vm.network :private_network, ip: "172.16.240.10"
    master.vm.network :forwarded_port, guest: 22, host: 2401, id: "ssh"

    #master.vm.synced_folder "ansible/", "/vagrant/ansible/" #, type: 'nfs'

    master.vm.provision :hosts do |provisioner|
      provisioner.autoconfigure = true
      provisioner.add_host '127.0.0.1', ['desktop01.bydefault-cl.test', 'desktop01', 'ansible']
    end

  master.vm.provision :shell, :inline => "cd /vagrant && bash install.sh"
  #master.vm.provision :shell, :inline => "install.sh"
	#master.vm.provision "shell", path: "install.sh"
  end
end