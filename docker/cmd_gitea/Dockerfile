# syntax = docker/dockerfile:experimental@sha256:de85b2f3a3e8a2f7fe48e8e84a65f6fdd5cd5183afa6412fff9caa6871649c44

# golang:1.15.2
FROM golang@sha256:da7ff43658854148b401f24075c0aa390e3b52187ab67cab0043f2b15e754a68 AS stage1

ENV GOCACHE=/root/.cache/go/gocache
ENV GOMODCACHE=/root/.cache/go/gomodcache
ENV CGO_ENABLED=0
ENV GOPATH=

COPY go.mod go.sum .

RUN --mount=type=cache,target=/root/.cache/go go build github.com/play-with-go/gitea/cmd/gitea

# buildpack-deps:buster-scm - because for now we need ssh-keyscan
FROM buildpack-deps@sha256:f010c9887ecea10d052247ef8befb79c2d17ea3f92ab6cb05039caab757fb14e

RUN mkdir /runbin

COPY --from=stage1 /go/gitea /runbin
COPY ./docker/cmd_gitea/playwithgo-entrypoint.sh /playwithgo-entrypoint.sh

ENTRYPOINT ["/playwithgo-entrypoint.sh"]
