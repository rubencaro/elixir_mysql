#!/bin/bash


MYSQL_USER="testuser"
MYSQL_PASS="testpassword"
MYSQL_DB="testdb"

/usr/bin/mysqld_safe > /dev/null 2>&1 &

echo "=> Waiting for confirmation of MySQL service startup"
RET=1
while [[ RET -ne 0 ]]; do
  sleep 5
  mysql -uroot -e "status" > /dev/null 2>&1
  RET=$?
done

echo "=> Creating MySQL user ${MYSQL_USER} with ${MYSQL_PASS} password"
mysql -uroot -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '$MYSQL_PASS'"
mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%' WITH GRANT OPTION"

echo "=> Creating database $MYSQL_DB"
RET=1
while [[ RET -ne 0 ]]; do
  sleep 5
  mysql -uroot -e "CREATE DATABASE $MYSQL_DB"
  RET=$?
done
echo "=> Done!"


mysqladmin -uroot shutdown
