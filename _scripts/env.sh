#!/usr/bin/env bash

set -euo pipefail

export="$2"
alias="$3"

if [ "$export" = "" ]
then
	export="export"
fi

if [ "$alias" = "" ]
then
	alias="alias"
fi

echo $export GOPRIVATE=github.com/play-with-go/*
