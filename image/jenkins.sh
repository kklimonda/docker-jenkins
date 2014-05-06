#!/bin/bash
set -e
source /build/buildconfig
set -x

## we need virtualenv, some libraries and postgres 9.3, and the Java VM.
$minimal_apt_get_install python-virtualenv libjpeg-dev libpng-dev libpq-dev \
  postgresql-9.3 openjdk-7-jre-headless git build-essential python-dev imagemagick \
  ghostscript

# fetch the jenkins package from their site
curl -o /opt/jenkins.war http://ftp.icm.edu.pl/packages/jenkins/war/1.562/jenkins.war

# postgres needs access to the snakeoil cert.
#usermod -a -G ssl-cert postgres
#chown :postgres /etc/ssl/private/
#chmod 0770 /etc/ssl/private/
#chmod 0640 /etc/ssl/private/ssl-cert-snakeoil.key

# lets prepare a root jenkins folder for data
mkdir /jenkins
ln -sf /jenkins /root/.jenkins

## This tool runs a command as another user and sets $HOME.
cp /build/setuser /sbin/setuser
cp /build/phantomjs /usr/local/bin/

# enable postgresql-9.3 server
mkdir /etc/service/postgresql-9.3/
cp /build/runit/postgres-9.3 /etc/service/postgresql-9.3/run

mkdir /etc/service/jenkins/
cp /build/runit/jenkins /etc/service/jenkins/run
