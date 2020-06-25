#!/usr/bin/env bash

set -euo pipefail

eval "$($( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/env.sh bash)"

export GOMODCACHE="$(go env GOPATH | cut -f 1 -d :)"/pkg/mod

args="$@"
if [ "$1" == "up" ] || [ "$1" == "down" ] || [ "$1" == "stop" ]
then
	first="$1 -t 0"
	shift
	args="$first $@"
fi

docker-compose $args
