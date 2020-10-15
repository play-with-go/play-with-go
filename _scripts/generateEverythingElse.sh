#!/usr/bin/env bash

set -euo pipefail
shopt -s inherit_errexit

eval "$($( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/env.sh bash)"

cd "$( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.."

go generate ./...

# If we are building main, then checkout a copy of site
if [ "${GITHUB_ACTIONS:-}" == "true" ] && [ "${GITHUB_WORKFLOW:-}" == "Test" ] && [ "$(basename $GITHUB_REF)" == "main" ]
then
	git clone https://playwithgopher:$PLAYWITHGOPHER_GITHUB_PAT@github.com/play-with-go/site _site
	pushd _site > /dev/null
	git config user.email "paul+playwithgopher@myitcv.io"
	git config user.name "playwithgopher"
	popd > /dev/null
fi

./_scripts/dc.sh -f docker-compose.yml -f docker-compose-website.yml run --rm -e JEKYLL_UID=$(id -u) -e JEKYLL_GID=$(id -g) site
