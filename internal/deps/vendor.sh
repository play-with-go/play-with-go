#!/usr/bin/env bash

set -euo pipefail
shopt -s inherit_errexit

go mod download

# Use the git root to simulate the CUE module root
cd $(git rev-parse --show-toplevel)

for i in "$@"
do
	dir=$(go list -m -f={{.Dir}} $i)
	mkdir -p ./cue.mod/pkg/$i
	(command cd $dir && find -type d -name internal -prune -o -type d -name cue.mod -prune -o -iname "*_tool.cue" -prune -o -type f -iname "*.cue" -print) | rsync -a --delete --chmod=Du+w,Fu+w --files-from=- $dir ./cue.mod/pkg/$i
done

go mod tidy
