Vagrant LAMP with Craft CMS
===========================
Based on [mattandersen/vagrant-lamp](https://github.com/mattandersen/vagrant-lamp).

This project is aimed to be a starting point for developing a Craft CMS site that "just works" on all contributors machines.

The shared folders of this vagrant setup are
	public (the web root)
	craft/templates
	craft/config
	craft/plugins
	
Everything else is automatically downloaded!

Requirements
------------
* VirtualBox <http://www.virtualbox.com>
* Vagrant <http://www.vagrantup.com>
* Git <http://git-scm.com/>

Usage
-----

### Setting up a new Project
* fork this repository
* clone it to your machine
* copy all files from git-hooks to .git/hooks
* vagrant up
* add "127.0.0.1 craft.dev" to your /etc/hosts file
* browse to craft.dev:4242/admin and setup craft (+ activate craft pro)
* start coding!

Technical Details
-----------------
* Ubuntu 14.04 64-bit
* Apache 2
* PHP 5.5
* MySQL 5.5
* Craft 2.3
