#!/usr/bin/env bash

set -euo pipefail

source "$( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"/env_common.bash

# Must be set first because the go list commands below rely on it
$export GOPRIVATE github.com/play-with-go/*

# We need to ensure everything is downloaded else the go list -m commands that
# follow will not work
go mod download

modRoot="$(go list -m -f {{.Dir}})"
pwdRoot="$(go list -m -f {{.Dir}} github.com/play-with-docker/play-with-docker)"
giteaRoot="$(go list -m -f {{.Dir}} github.com/play-with-go/gitea)"

GOBIN=$modRoot/.bin go install github.com/myitcv/docker-compose

$export COMPOSE_PROJECT_NAME playwithgo
$export COMPOSE_FILE "$pwdRoot/docker-compose.yml:$giteaRoot/docker-compose.yml:$modRoot/docker-compose.yml"
$export PATH "$modRoot/.bin:$PATH"
mkcertRoot="$(mkcert -CAROOT)"
rootCA="$(cat $mkcertRoot/rootCA.pem)"
$export PLAYWITHGO_ROOTCA "$rootCA"
if [ "${PLAYWITHGODEV_CERT_FILE:-}" == "" ]
then
	certFile="$(cat $mkcertRoot/play-with-go.dev/cert.pem)"
	keyFile="$(cat $mkcertRoot/play-with-go.dev/key.pem)"
	$export PLAYWITHGODEV_CERT_FILE "$certFile"
	$export PLAYWITHGODEV_KEY_FILE "$keyFile"
fi

if [ "${PLAYWITHGODEV_ROOT_USER:-}" == "" ]
then
	$export PLAYWITHGODEV_ROOT_USER root
	$export PLAYWITHGODEV_ROOT_PASSWORD asdffdsa
fi
