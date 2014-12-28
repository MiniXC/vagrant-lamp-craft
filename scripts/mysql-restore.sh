#!/bin/bash

mysql -u root -p$2 $1 < /home/vagrant/mysql/dump.sql && echo "Restoring MySQL Database from dump.sql..."
