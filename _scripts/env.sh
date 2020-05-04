#!/usr/bin/env bash

set -euo pipefail

source "$( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"/env_common.bash

$export GOPRIVATE github.com/play-with-go/*
