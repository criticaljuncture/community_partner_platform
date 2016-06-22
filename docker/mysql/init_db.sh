#!/bin/bash

mysqladmin -u root create $MYSQL_PORT_3306_TCP_DATABASE
gzip -cd /current.sql.gz | mysql -u root $MYSQL_PORT_3306_TCP_DATABASE
