#!/bin/bash

#
# Install the software-properties-common package.
#
# This installs, among other things, the
# 'add-apt-repository' command, which simplifies
# adding configuration files for additional
# APT package repository.
#
apt-get update && apt-get install -y software-properties-common

#
# Install Oracle/Sun JDK 7
#
add-apt-repository -y ppa:webupd8team/java
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
apt-get update && apt-get -y install oracle-jdk7-installer
update-alternatives --display java
# Set Oracle JDK 7 as the system's default Java
apt-get update && apt-get install oracle-java7-set-default

#
# Install wget
#
apt-get update && apt-get install -y wget

#
# Install Maven and Ant
#
apt-get update && apt-get install -y maven ant

#
# Install the PostgreSQL client and FTP client
#
apt-get update && apt-get install -y postgresql-client ftp

#
# Install Nuxeo dependencies
#
apt-get update && apt-get install -y imagemagick

exit 0