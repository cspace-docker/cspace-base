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
# Install the Oracle JDK and a set of other tools we'll need.
#
ADD install-tool-dependencies.sh install-tool-dependencies.sh
RUN chmod ug+x install-tool-dependencies.sh
RUN ./install-tool-dependencies.sh

#
# Add a bash script that we'll use to set environment variables in the /etc/environment system file.
#
ADD add-env-vars.sh add-env-vars.sh
RUN chmod ug+x add-env-vars.sh

#
# Setup the Tools' environment variables.
#
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
ENV MAVEN_OPTS -Xmx768m -XX:MaxPermSize=512m
ENV ANT_OPTS -Xmx768m -XX:MaxPermSize=512m
RUN ./add-env-vars.sh $JAVA_HOME $MAVEN_OPTS $ANT_OPTS

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

