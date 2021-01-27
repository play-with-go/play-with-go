# syntax = docker/dockerfile@sha256:e2a8561e419ab1ba6b2fe6cbdf49fd92b95912df1cf7d313c3e2230a333fdbcc
# SHA256 above is an absolute reference to docker/dockerfile:1.2.1

# The comment regarding the syntax reference is not at the top of the file
# because the syntax line must be the first in the file.

# golang:1.15.7
FROM golang@sha256:c161abf0cde3969e05f6914a86cab804b2b0df515f4ff9570475b25547ba7959 AS stage1

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
