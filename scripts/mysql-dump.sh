#!/bin/bash
mysqldump -u root -p$2 $1 > /home/vagrant/mysql/dump.sql && echo "Backing up MySQL Database to dump.sql..."
