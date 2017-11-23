#!/usr/bin/env bash

function install {
  echo installing $1
  shift
  apt-get -y install "$@" >/dev/null 2>&1
}

echo updating package information
apt-add-repository -y ppa:brightbox/ruby-ng >/dev/null 2>&1
apt-get -y update >/dev/null 2>&1

install 'development tools' build-essential

install Ruby ruby2.3 ruby2.3-dev
update-alternatives --set ruby /usr/bin/ruby2.3 >/dev/null 2>&1
update-alternatives --set gem /usr/bin/gem2.3 >/dev/null 2>&1

echo installing Bundler
gem install bundler -N >/dev/null 2>&1

install Git git

install PostgreSQL postgresql postgresql-contrib libpq-dev
sudo -u postgres createuser --superuser ubuntu
sudo -u postgres createdb -O ubuntu groupdate_test

debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
install MySQL mysql-server libmysqlclient-dev
mysql -uroot -proot <<SQL
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('');
CREATE DATABASE groupdate_test;
SQL
mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql

install 'Sqlite' libsqlite3-dev

echo installing cockroachdb
wget -qO- https://binaries.cockroachdb.com/cockroach-v1.1.2.linux-amd64.tgz | tar  xvz
cp -i cockroach-v1.1.2.linux-amd64/cockroach /usr/local/bin
chmod a+x /usr/local/bin/cockroach
cockroach start --insecure --host=localhost &



