#!/usr/bin/env bash

set -euo pipefail
shopt -s inherit_errexit

eval "$($( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/env.sh bash)"

cd "$( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.."

set -x

if  [ "${GITHUB_ACTIONS:-}" != "true" ] || [ "${GITHUB_WORKFLOW:-}" != "Test" ]
then
	exit
fi

if [ "$GITHUB_REF" == "refs/heads/main" ]
then
	# When building main republish the site
	pushd _site > /dev/null
	if [ "$(git status --porcelain)" == "" ]
	then
		echo "Nothing to publish"
		exit
	fi
	git add -A
	git commit -am "Build $(date +%Y%m%d%H%M%S_%N)"
	git push
	popd > /dev/null
elif [[ "$GITHUB_REF" == refs/tags/v* ]]
then
	# Only update the DockerHub images on new tags

	# TODO: a bit gross that we end up using the :latest tag here...
	docker login -u $DOCKER_HUB_USER -p $DOCKER_HUB_TOKEN
	./_scripts/dc.sh push controller cmd_gitea
fi
