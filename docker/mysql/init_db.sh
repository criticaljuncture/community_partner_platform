#!/bin/bash
echo "INIT!!!!!!"
for i in $MYSQL_PORT_3306_TCP_DATABASE; do
  if mysqlshow -uroot $i | grep -v Wildcard | grep -o $i --quiet; then
    echo "Info: Database $i exists, doing nothing"
  else
    echo "Info: Database $i does not exist, creating and loading data"
    mysqladmin -u root create $i
    gzip -cd ${i}_current.sql.gz | mysql -u root $i
  fi
done
