#
# Notes: "DEBIAN_FRONTEND=noninteractive" (http://snowulf.com/2008/12/04/truly-non-interactive-unattended-apt-get-install/)
#
FROM base
MAINTAINER Richard Millet "richard.millet@berkeley.edu"

RUN echo Installing the Oracle/Sun JDK 7
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get -y update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get -y install oracle-jdk7-installer
RUN update-alternatives --display java
RUN java -version
RUN javac -version
RUN apt-get install oracle-java7-set-default

ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
RUN export JAVA_HOME=$JAVA_HOME
RUN echo JAVA_HOME=$JAVA_HOME >> /etc/environment

#
# Install Apache Tomcat 6
#
#RUN apt-get install -y tomcat6

#
# Install Maven
#
RUN apt-get install -y maven

#
# Install Ant
#
RUN apt-get install -y ant

#
# Get just the Postgres client and FTP client
#
RUN apt-get install -y postgresql-client
RUN apt-get install -y ftp

#
# The home directory for all user accounts
#
ENV HOME /home

#
# Create a user named 'cspace'
#
ENV CSPACE_USERNAME cspace
ENV CSPACE_USER_PASSWORD cspace
RUN useradd $CSPACE_USERNAME -m
RUN echo $CSPACE_USER_PASSWORD$'\n'$CSPACE_USER_PASSWORD$'\n' | passwd $CSPACE_USERNAME

#
# Create a directory for the CollectionSpace Sources
#
RUN apt-get install -y git
RUN cd $HOME/$CSPACE_USERNAME && mkdir src
RUN cd $HOME/$CSPACE_USERNAME/src && git clone https://github.com/collectionspace/ui.git

#
# Install Nuxeo dependencies
#
RUN apt-get install -y imagemagick

#
# Get the latest CollectionSpace Release and setup its runtime environment
#

#
# Finally export port 8080 to our host
#
EXPOSE :8080
