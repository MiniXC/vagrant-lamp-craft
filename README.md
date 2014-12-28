Vagrant LAMP with Craft CMS
===========================

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
* vagrant up
* add "192.168.42.42 craft.dev" to your /etc/hosts file
* browse to craft.dev/admin and setup craft
* start coding!

Technical Details
-----------------
* Ubuntu 14.04 64-bit
* Apache 2
* PHP 5.5
* MySQL 5.5
* Craft (latest)
