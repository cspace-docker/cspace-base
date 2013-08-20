#!/bin/bash

for arg; do
	echo $arg=${!arg}
done

exit 0