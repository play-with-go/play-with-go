#!/usr/bin/env bash

set -euo pipefail
shopt -s inherit_errexit

# If we are building a pull request it might be that we are
# testing the upgrade of a preguide version that as not yet
# been merged. If so, then we can fall back to building locally
if [ "${GITHUB_ACTIONS:-}" != "true" ] || [ "$GITHUB_EVENT_NAME" == "pull_request" ]
then
	preguideVersion="$(go list -m -f {{.Version}} github.com/play-with-go/preguide)"
	preguideDir="$(go list -m -f {{.Dir}} github.com/play-with-go/preguide)"
	docker pull playwithgo/preguide:$preguideVersion || \
		bash "$preguideDir/_scripts/dockerBuildSelf.sh"
fi
