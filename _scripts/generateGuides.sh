#!/usr/bin/env bash

set -euo pipefail
shopt -s inherit_errexit

eval "$($( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/env.sh bash)"

cd "$( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.."

# Only force the skip of cache on main
if [ "${GITHUB_REF:-}" == "refs/heads/main" ] || [[ "${GITHUB_REF:-}" == refs/tags/v* ]]
then
	export PREGUIDE_SKIP_CACHE=true
fi

function join_by { local d=$1; shift; local f=$1; shift; printf %s "$f" "${@/#/$d}"; }

run=""
if [ "$#" != "0" ]
then
	export PREGUIDE_RUN="$(join_by '|' "$@")"
fi

go generate -tags guides ./guides
