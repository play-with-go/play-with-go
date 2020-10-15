#!/usr/bin/env bash

set -euo pipefail
shopt -s inherit_errexit

eval "$($( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/env.sh bash)"

args=("$@")
if [ "${1:-}" == "up" ] || [ "${1:-}" == "down" ] || [ "${1:-}" == "stop" ]
then
	args=("$1" -t 0 "${args[@]:1}")
fi
docker-compose "${args[@]}"
