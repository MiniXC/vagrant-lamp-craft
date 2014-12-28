#!/bin/bash

mysqldump -u root -p$mysql_pass $mysql_db > /home/vagrant/mysql/dump.sql && echo "Backing up MySQL Database to dump.sql..."
