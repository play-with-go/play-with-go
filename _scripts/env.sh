#!/usr/bin/env bash

set -euo pipefail
shopt -s inherit_errexit

source "$( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"/env_common.bash

# We need to ensure everything is downloaded else the go list -m commands that
# follow will not work
go mod download

modRoot="$(go list -m -f {{.Dir}})"

$export COMPOSE_PROJECT_NAME playwithgo
$export PATH "$modRoot/.bin:$PATH"
$export PREGUIDE_CONFIG "$modRoot/prestep_conf.cue"
mkcertRoot="$(mkcert -CAROOT)"
rootCA="$(cat "$mkcertRoot/rootCA.pem")"
$export GOPHERLIVE_ROOTCA "$rootCA"
if [ "${PLAYWITHGODEV_CERT_FILE:-}" == "" ]
then
	certFile="$(cat "$mkcertRoot/gopher.live/cert.pem")"
	keyFile="$(cat "$mkcertRoot/gopher.live/key.pem")"
	$export PLAYWITHGODEV_CERT_FILE "$certFile"
	$export PLAYWITHGODEV_KEY_FILE "$keyFile"
fi

if [ "${PLAYWITHGODEV_ROOT_USER:-}" == "" ]
then
	$export PLAYWITHGODEV_ROOT_USER root
	$export PLAYWITHGODEV_ROOT_PASSWORD asdffdsa
fi
$export PREGUIDE_PULL_IMAGE missing
$export COMPOSE_DOCKER_CLI_BUILD 1
$export DOCKER_BUILDKIT 1
