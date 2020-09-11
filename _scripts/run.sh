#!/usr/bin/env bash

set -euo pipefail

pkg=$1
env=$2
shift 2

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

if [ "$(go env GOOS GOARCH)" != "$(echo -e "linux\namd64")" ]
then
	bin="$( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/../.bin"
	GOOS=linux GOARCH=amd64 go build -o $bin $pkg
	export $env="$bin/$(basename $pkg)"
fi

go run $pkg "$@"
