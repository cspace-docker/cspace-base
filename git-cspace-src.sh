#!/bin/bash

#
# Create a Linux user account named 'cspace'
#
useradd $CSPACE_USERNAME -m -s /bin/bash
echo $CSPACE_USER_PASSWORD$'\n'$CSPACE_USER_PASSWORD$'\n' | passwd $CSPACE_USERNAME

#
# Install git, create a 'src' directory and clone the CollectionSpace repos
#
apt-get update && apt-get install -y git
cd $USER_HOME/$CSPACE_USERNAME && mkdir src
cd $USER_HOME/$CSPACE_USERNAME/src && git clone https://github.com/collectionspace/application.git
cd $USER_HOME/$CSPACE_USERNAME/src && git clone https://github.com/collectionspace/services.git
cd $USER_HOME/$CSPACE_USERNAME/src && git clone https://github.com/collectionspace/ui.git
chown -R $CSPACE_USERNAME $USER_HOME/$CSPACE_USERNAME

exit 0
