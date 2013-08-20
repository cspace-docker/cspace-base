#!/bin/bash

#
# Create a Linux user account named 'cspace'
#
useradd $CSPACE_USERNAME -m -s /bin/bash
echo $CSPACE_USER_PASSWORD$'\n'$CSPACE_USER_PASSWORD$'\n' | passwd $CSPACE_USERNAME

#
# Install git, create a 'src' directory and clone the CollectionSpace repos
#
apt-get install -y git
cd $HOME/$CSPACE_USERNAME && mkdir src
cd $HOME/$CSPACE_USERNAME/src && git clone https://github.com/collectionspace/ui.git
chown -R $CSPACE_USERNAME $HOME/$CSPACE_USERNAME

quit
END_SCRIPT
exit 0
