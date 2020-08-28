#!/usr/bin/env bash

set -eu -o pipefail
shopt -s inherit_errexit

# Simply delegate to the gitea script
bash $(go list -m -f {{.Dir}} github.com/play-with-go/gitea)/_scripts/setupmkcert.sh
