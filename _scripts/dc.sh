#!/usr/bin/env bash

set -euo pipefail

eval "$($( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/env.sh bash)"

bin="$( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/../.bin"

GOBIN=$bin go install github.com/play-with-docker/play-with-docker github.com/play-with-docker/play-with-docker/router/l2

export GOMODCACHE="$(go env GOPATH | cut -f 1 -d :)"/pkg/mod

args="$@"
if [ "$1" == "up" ] || [ "$1" == "down" ] || [ "$1" == "stop" ]
then
	first="$1 -t 0"
	shift
	args="$first $@"
fi

docker-compose $args
