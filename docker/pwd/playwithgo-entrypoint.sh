#!/bin/sh

set -eu

if [ ! -f /etc/ssh/ssh_host_rsa_key ]
then
	ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
fi
exec /runbin/pwd "$@"
