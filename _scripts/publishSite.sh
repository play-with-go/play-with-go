#!/usr/bin/env bash

set -euo pipefail
shopt -s inherit_errexit

eval "$($( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/env.sh bash)"

cd "$( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.."

if [ "${GITHUB_ACTIONS:-}" == "true" ] && [ "${GITHUB_WORKFLOW:-}" == "Test" ] && [ "$(basename $GITHUB_REF)" == "main" ]
then
	cd _site
	if [ "$(git status --porcelain)" == "" ]
	then
		echo "Nothing to publish"
		exit
	fi
	git add -A
	git commit -am "Build $(date +%Y%m%d%H%M%S_%N)"
	git push
fi
