#!/usr/bin/env bash

set -euo pipefail

"$( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/run.sh" github.com/play-with-go/preguide/cmd/preguide PREGUIDE_LINUX_AMD64_SELF
