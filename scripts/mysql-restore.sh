#!/bin/bash

mysql -u root -p$mysql_pass $mysql_db < /home/vagrant/mysql/dump.sql && echo "Restoring MySQL Database from dump.sql..."
