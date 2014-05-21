#
# Notes: "DEBIAN_FRONTEND=noninteractive" (http://snowulf.com/2008/12/04/truly-non-interactive-unattended-apt-get-install/)
#
FROM ubuntu:14.04
MAINTAINER Richard Millet "richard.millet@berkeley.edu"

#
# Install the Oracle JDK and a set of other tools we'll need.
#
ADD install-tool-dependencies.sh install-tool-dependencies.sh
RUN chmod ug+x install-tool-dependencies.sh
RUN ./install-tool-dependencies.sh

#
# Add a bash script that we'll later use to set environment variables
# in the /etc/environment system file.
#
ADD add-env-vars.sh add-env-vars.sh
RUN chmod ug+x add-env-vars.sh

#
# Set environment variables for later creating a Linux user account
# named 'cspace'.
#
ENV USER_HOME /home
ENV CSPACE_USERNAME cspace
ENV CSPACE_USER_PASSWORD cspace

#
# Set up environment variables for tools.
#
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
ENV MAVEN_OPTS -Xmx768m -XX:MaxPermSize=512m
ENV ANT_OPTS -Xmx768m -XX:MaxPermSize=512m

#
# Add these environment variables to /etc/environment
#
RUN ./add-env-vars.sh USER_HOME CSPACE_USERNAME JAVA_HOME MAVEN_OPTS ANT_OPTS

#
# Add and run a bash script to set up a directory for
# CollectionSpace source code and download that source code.
#
ADD git-cspace-src.sh git-cspace-src.sh
RUN chmod ug+x git-cspace-src.sh
RUN ./git-cspace-src.sh

