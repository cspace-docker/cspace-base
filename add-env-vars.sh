#!/bin/bash

for arg; do
	echo $arg=${!arg} >> /etc/environment
done

exit 0