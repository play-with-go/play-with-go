#!/usr/bin/env bash

set -euo pipefail

eval "$($( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/env.sh bash)"

# Check we have the required variables set
if [ "${PLAYWITHGODEV_GITHUB_USER:-}" == "" ]
then
	echo "warning: PLAYWITHGODEV_GITHUB_USER is not set"
fi
if [ "${PLAYWITHGODEV_GITHUB_PAT:-}" == "" ]
then
	echo "warning: PLAYWITHGODEV_GITHUB_PAT is not set"
fi

bin="$( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/../.bin"

CGO_ENABLED=0 GOBIN=$bin go install github.com/play-with-docker/play-with-docker github.com/play-with-docker/play-with-docker/router/l2 \
	github.com/play-with-go/gitea/cmd/gitea github.com/play-with-go/play-with-go/cmd/controller

export GOMODCACHE="$(go env GOPATH | cut -f 1 -d :)"/pkg/mod

args="$@"
if [ "$1" == "up" ] || [ "$1" == "down" ] || [ "$1" == "stop" ]
then
	first="$1 -t 0"
	shift
	args="$first $@"
fi

docker-compose $args
