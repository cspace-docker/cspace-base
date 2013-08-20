for arg; do
	echo ${!arg*}=$arg
#   echo "$arg"="$arg" >> /etc/environment
done
