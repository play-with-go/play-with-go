#!/usr/bin/env bash

set -euo pipefail

source "$( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"/env_common.bash

modRoot="$(go list -m -f {{.Dir}})"

GOBIN=$modRoot/.bin go install github.com/myitcv/docker-compose

$export COMPOSE_PROJECT_NAME playwithgo
$export PATH "$modRoot/.bin:$PATH"
