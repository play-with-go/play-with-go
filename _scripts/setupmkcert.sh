#!/usr/bin/env bash

set -eu -o pipefail
shopt -s inherit_errexit

# Ensure we have the relevant module available
go mod download github.com/play-with-go/gitea

# Simply delegate to the gitea script
bash $(go list -m -f {{.Dir}} github.com/play-with-go/gitea)/_scripts/setupmkcert.sh
