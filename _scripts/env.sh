#!/usr/bin/env bash

set -euo pipefail

source "$( command cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"/env_common.bash

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
$export PREGUIDE_CONFIG "$modRoot/prestep_conf.cue"
mkcertRoot="$(mkcert -CAROOT)"
rootCA="$(cat "$mkcertRoot/rootCA.pem")"
$export PLAYWITHGO_ROOTCA "$rootCA"
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
$export PREGUIDE_DOCKER "busybox@sha256:2423a1efa0c8eeae54e2fc587c53c5161511d0c3882c2944febb2860577ad327"
$export PREGUIDE_PULL_IMAGE missing
$export PREGUIDE_DEVEL_HASH true
