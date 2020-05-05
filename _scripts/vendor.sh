#!/usr/bin/env bash

source "${BASH_SOURCE%/*}/common.bash"

go mod download

for i in "$@"
do
	dir=$(go list -m -f={{.Dir}} $i)

	cd $(git rev-parse --show-toplevel)

	mkdir -p ./cue.mod/pkg/$i

	(command cd $dir && find -type f -iname "*.cue") | rsync -a --delete --chmod=Du+w,Fu+w --files-from=- $dir ./cue.mod/pkg/$i
done

go mod tidy
