Vagrant LAMP with Craft CMS
===========================
Based on [mattandersen/vagrant-lamp](https://github.com/mattandersen/vagrant-lamp).

This project provides a LAMP stack with Craft CMS installed. You can use this to develop for Craft CMS with version control, or just test something locally without having to worry about setting up a LAMP installation for Craft.

This setup is based on instead of ignoring /craft/app and /craft/storage (those two don't contain any files developers can change), they are on the vagrant machine, but not synced with the repo.
This makes for a much cleaner install, and provides just the directories you need for developing, and nothing more!

Synced folders
--------------
| Usage         | Guest (Vagrant Machine) | Host (Repository)  |
| ------------  | --------------- | ----- |
| web root      | public          | public |
| [config files](http://buildwithcraft.com/docs/folder-structure#craft-config) | /var/www/craft/config    |  craft/config |
| [plugins](http://buildwithcraft.com/docs/folder-structure#craft-plugins) | /var/www/craft/plugins | craft/plugins |
| [custom logo](http://buildwithcraft.com/docs/folder-structure#craft-storage) | /var/www/craft/storage/logo | craft/logo |
| [templates](http://buildwithcraft.com/docs/templating-overview) | /var/www/craft/templates | craft/templates
| database backup | /home/vagrant/mysql | mysql |
| dump and restore scripts | /home/vagrant/scripts | scripts |

Requirements
------------
* [VirtualBox](http://www.virtualbox.com)
* [Vagrant](http://www.vagrantup.com)
* [Git](http://git-scm.com/)

Getting Started
---------------

### Simple Setup
If you want to use this project for developing locally, testing things out or anything else that doesn't include version control just `git clone` this repository.

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
