# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network :private_network, ip: "192.168.42.42"

	# Forward ports to Apache and MySQL
  config.vm.network "forwarded_port", guest: 80, host: 4242
  config.vm.network "forwarded_port", guest: 3306, host: 8484

	config.vm.synced_folder "public", "/var/www/html"
  config.vm.synced_folder "craft/plugins", "/var/www/craft/plugins"
  config.vm.synced_folder "craft/templates", "/var/www/craft/templates"
  config.vm.synced_folder "craft/config", "/var/www/craft/config"
  config.vm.synced_folder "mysql", "/home/vagrant/mysql"
  config.vm.synced_folder "scripts", "/home/vagrant/scripts"

	config.vm.provision "shell", path: "provision.sh"

  # Fix tty Error
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  # config.vm.provider "virtualbox" do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
end
