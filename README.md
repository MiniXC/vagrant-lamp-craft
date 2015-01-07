Vagrant LAMP with Craft CMS
===========================
Based on [mattandersen/vagrant-lamp](https://github.com/mattandersen/vagrant-lamp).

This project provides a LAMP stack with Craft CMS installed. You can use this to develop for Craft CMS with version control, or just test something locally without having to worry about setting up a LAMP installation for Craft.

This setup is based on instead of ignoring /craft/app and /craft/storage (those two don't contain any files developers can change), they are on the vagrant machine, but not synced with the repo.
This makes for a much cleaner install, and provides just the directories you need for developing, and nothing more!

Synced folders
--------------
|                                  Usage                                       | Guest (Vagrant Machine)     | Host (Repository)  |
| ---------------------------------------------------------------------------- | --------------------------- | ------------------ |
| web root                                                                     | public                      | public             |
| [config files](http://buildwithcraft.com/docs/folder-structure#craft-config) | /var/www/craft/config       | craft/config       |
| [plugins](http://buildwithcraft.com/docs/folder-structure#craft-plugins)     | /var/www/craft/plugins      | craft/plugins      |
| [custom logo](http://buildwithcraft.com/docs/folder-structure#craft-storage) | /var/www/craft/storage/logo | craft/logo         |
| [templates](http://buildwithcraft.com/docs/templating-overview)              | /var/www/craft/templates    | craft/templates    |
| database backup                                                              | /home/vagrant/mysql         | mysql              |
| dump and restore scripts                                                     | /home/vagrant/scripts       | scripts            |

Requirements
------------
* [VirtualBox](http://www.virtualbox.com)
* [Vagrant](http://www.vagrantup.com)
* [Git](http://git-scm.com/)

Getting Started
---------------

### Simple Setup
If you want to use this project for developing locally, testing things out or anything else that doesn't include version control, just `git clone` this repository and run `vagrant up` in its folder.

### Advanced Setup
To use this project as a starting point for your next Craft CMS project using a Github repository you have to run the following lines in your console.

    $ git clone https://github.com/MiniXC/vagrant-lamp-craft
    $ cd vagrant-lamp-craft
    $ chmod +x hooks/*
    $ cp hooks/* .git/hooks
    $ vagrant up

This will dump your database to a file and add it to git whenever you commit. The database will be restored from this file `post-merge`, meaning whenever you download from your repository.

### Accessing your Server
Add `192.168.42.42 craft.dev` to your hosts file to access your server on your host machine, just by pointing you browser to `craft.dev`.

#### Troubleshooting
If `192.168.42.42` conflicts with your ip address scheme, you have several options.
* manually change the ip in your `Vagrantfile`
* add `127.0.0.1 craft.dev` to your hosts file instead

### Changing default Values
If you want to change a variable, make sure to do so in all the right places of this project.

| Variable       | Default Value |                                          Files                                  |
| -------------- | ------------- | ------------------------------------------------------------------------------- |
| Guest IP       | 192.168.42.42 | `Vagrantfile` `/etc/hosts`                                                      |    
| Database Name  | craft         | `provision.sh` `/scripts/pre-commit` `scripts/post-merge` `craft/config/db.php` |
| MySQL Password | root          | `provision.sh` `/scripts/pre-commit` `scripts/post-merge` `craft/config/db.php` |

### Manually dumping/restoring the Database
Do this with `vagrant ssh` on the server. Run `scripts/mysql-dump.sh` with two parameters (database and mysql password) to dump the database to `mysql/dump.sql` on your host. Do the same with `scripts/mysql-restore.sh` to resore the database from this file.

Technical Details
-----------------
* Ubuntu 14.04 64-bit
* Apache 2
* PHP 5.5
* MySQL 5.5
* Craft CMS 2.3
