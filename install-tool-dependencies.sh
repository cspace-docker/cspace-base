#!/bin/bash

#
# Install wget
#
apt-get install -y wget

#
# Install Oracle/Sun JDK 7
#
apt-get install -y software-properties-common
add-apt-repository -y ppa:webupd8team/java
apt-get -y update
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
apt-get -y install oracle-jdk7-installer
update-alternatives --display java
# Set Oracle JDK 7 as the system's default Java
apt-get install oracle-java7-set-default

#
# Install Maven and Ant
#
apt-get install -y maven ant

#
# Install the PostgreSQL client and FTP client
#
apt-get install -y postgresql-client ftp

#
# Install Nuxeo dependencies
#
apt-get install -y imagemagick

exit 0