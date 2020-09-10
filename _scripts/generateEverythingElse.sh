#!/usr/bin/env bash

set -euo pipefail

eval "$($( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/env.sh bash)"

cd "$( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.."

go generate ./...
