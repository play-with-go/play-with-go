# syntax = docker/dockerfile@sha256:e2a8561e419ab1ba6b2fe6cbdf49fd92b95912df1cf7d313c3e2230a333fdbcc
# SHA256 above is an absolute reference to docker/dockerfile:1.2.1

# The comment regarding the syntax reference is not at the top of the file
# because the syntax line must be the first in the file.

# golang:1.16
FROM golang@sha256:f3f90f4d30866c1bdae90012b506bd5e557ce27ccd2510ed30a011c44c1affc8 AS stage1

ENV GOCACHE=/root/.cache/go/gocache
ENV GOMODCACHE=/root/.cache/go/gomodcache
ENV CGO_ENABLED=0
ENV GOPATH=

COPY go.mod go.sum .
COPY cmd/ ./cmd

RUN --mount=type=cache,target=/root/.cache/go go build -o cmd/controller/controller ./cmd/controller

# busybox 1.32.0
FROM busybox@sha256:d366a4665ab44f0648d7a00ae3fae139d55e32f9712c67accd604bb55df9d05a

RUN mkdir /runbin

COPY --from=stage1 /go/cmd/controller/controller /runbin
COPY ./docker/controller/playwithgo-entrypoint.sh /playwithgo-entrypoint.sh
COPY ./prestep_conf.cue /start/
COPY ./guides /start/guides
COPY ./cue.mod /start/

ENTRYPOINT ["/playwithgo-entrypoint.sh"]
