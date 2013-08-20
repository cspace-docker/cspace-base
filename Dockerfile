#
# Notes: "DEBIAN_FRONTEND=noninteractive" (http://snowulf.com/2008/12/04/truly-non-interactive-unattended-apt-get-install/)
#
FROM base
MAINTAINER Richard Millet "richard.millet@berkeley.edu"

#
# Install common software packages
#
RUN apt-get install -y software-properties-common wget

#
# Install the Installing the Oracle/Sun JDK 7
#
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get -y update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get -y install oracle-jdk7-installer
RUN update-alternatives --display java
RUN apt-get install oracle-java7-set-default
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
RUN echo JAVA_HOME=$JAVA_HOME >> /etc/environment

#
# Install Maven and Ant
#
RUN apt-get install -y maven ant
ENV MAVEN_OPTS -Xmx768m -XX:MaxPermSize=512m
RUN echo MAVEN_OPTS=$MAVEN_OPTS >> /etc/environment
ENV ANT_OPTS -Xmx768m -XX:MaxPermSize=512m
RUN echo ANT_OPTS=$ANT_OPTS >> /etc/environment

#
# Get just the Postgres client and FTP client
#
RUN apt-get install -y postgresql-client ftp

#
# The home directory for all user accounts
#
ENV HOME /home

#
# Create a Linux user account named 'cspace'
#
ENV CSPACE_USERNAME cspace
ENV CSPACE_USER_PASSWORD cspace

#
# Create a directory for the CollectionSpace Sources and download them
#
ADD git-cspace-src.sh git-cspace-src.sh
RUN chmod ug+x git-cspace-src.sh
RUN ./git-cspace-src.sh

#
# Install Nuxeo dependencies
#
#RUN apt-get install -y imagemagick

