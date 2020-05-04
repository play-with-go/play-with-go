#!/usr/bin/env bash

set -euo pipefail

eval "$($( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/env.sh bash)"

if [ "${PLAYWITHGODEV_GITHUB_USER:-}" == "" ]
then
	echo "PLAYWITHGODEV_GITHUB_USER is not set"
	exit 1
fi
if [ "${PLAYWITHGODEV_GITHUB_PAT:-}" == "" ]
then
	echo "PLAYWITHGODEV_GITHUB_PAT is not set"
	exit 1
fi

go run github.com/play-with-go/gitea/cmd/gitea setup
