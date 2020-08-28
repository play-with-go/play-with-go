#!/usr/bin/env bash

set -eu -o pipefail
shopt -s inherit_errexit

go mod download

# When the gitea prestep runs it does so using the go.mod file of
# the github.com/play-with-go/gitea module. This is somewhat confusing
# because it means we can't use the go.mod file for this module
# as the dependency reference. Hence until we have a better solution
# for the problem we will enforce that both this module and the
# github.com/play-with-go/gitea module use the same version of preguide
ourVersion=$(go list -m -f {{.Version}} github.com/play-with-go/preguide)
giteaVersion=$(command cd $(go list -m -f {{.Dir}} github.com/play-with-go/gitea) && go list -m -f {{.Version}} github.com/play-with-go/preguide)

if [ "$ourVersion" != "$giteaVersion" ]
then
	echo "$(go list -m) and github.com/play-with-go/gitea do not agree on a version of github.com/play-with-go/preguide"
	exit 1
fi
