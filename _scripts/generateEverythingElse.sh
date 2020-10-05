#!/usr/bin/env bash

set -euo pipefail
shopt -s inherit_errexit

eval "$($( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/env.sh bash)"

cd "$( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.."

go generate ./...

./_scripts/dc.sh -f docker-compose.yml -f docker-compose-website.yml run --rm -e JEKYLL_UID=$(id -u) -e JEKYLL_GID=$(id -g) site
