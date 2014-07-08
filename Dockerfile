#
# cspace-base Dockerfile
#
# Dockerfile 1 of 3 to install and configure a CollectionSpace
# server instance inside a Docker container.
#
# This Dockerfile is specific to and requires Ubuntu Linux,
# although most of its instructions should likely work with
# any recent Debian-based Linux distribution.
#
# Notes re non-interactive package installation, if needed:
# http://snowulf.com/2008/12/04/truly-non-interactive-unattended-apt-get-install/
#

#
# Start with an Ubuntu Linux 14.04 LTS image, downloadable
# from the Docker Hub registry.
#
FROM ubuntu:14.04
MAINTAINER Richard Millet "richard.millet@berkeley.edu"

ENV SCRIPT_INSTALL_DIR /usr/local/docker-scripts

#
# Install the Oracle JDK and a set of other tools we'll need.
#
ADD install-tool-dependencies.sh $SCRIPT_INSTALL_DIR/install-tool-dependencies.sh
RUN chmod ug+x $SCRIPT_INSTALL_DIR/install-tool-dependencies.sh
RUN $SCRIPT_INSTALL_DIR/install-tool-dependencies.sh

#
# Set environment variables for later creating a Linux user
# account named 'cspace'.
#
ENV USER_HOME /home
ENV CSPACE_USERNAME cspace
# TODO: Investigate how to generate a per-instance password
# for this user account.
ENV CSPACE_USER_PASSWORD cspace

#
# Set up environment variables needed by Java and
# Java-based build tools (Ant and Maven).
#
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
ENV MAVEN_OPTS -Xmx768m -XX:MaxPermSize=512m
ENV ANT_OPTS -Xmx768m -XX:MaxPermSize=512m

#
# Add and run a bash script to add these environment variables
# to the /etc/environment system file.
#
ADD add-env-vars.sh $SCRIPT_INSTALL_DIR/add-env-vars.sh
RUN chmod ug+x $SCRIPT_INSTALL_DIR/add-env-vars.sh
RUN $SCRIPT_INSTALL_DIR/add-env-vars.sh USER_HOME CSPACE_USERNAME JAVA_HOME MAVEN_OPTS ANT_OPTS

#
# Add and run a bash script to set up a directory for
# CollectionSpace source code and download that source code.
#
ADD git-cspace-src.sh $SCRIPT_INSTALL_DIR/git-cspace-src.sh
RUN chmod ug+x $SCRIPT_INSTALL_DIR/git-cspace-src.sh
RUN $SCRIPT_INSTALL_DIR/git-cspace-src.sh

