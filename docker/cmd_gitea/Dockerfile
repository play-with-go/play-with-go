# golang:1.19.1
FROM golang@sha256:2d17ffd12a2cdb25d4a633ad25f8dc29608ed84f31b3b983427d825280427095 AS stage1

ENV GOCACHE=/root/.cache/go/gocache
ENV GOMODCACHE=/root/.cache/go/gomodcache
ENV CGO_ENABLED=0
ENV GOPATH=

COPY go.mod go.sum .

RUN --mount=type=cache,target=/root/.cache/go go build github.com/play-with-go/gitea/cmd/gitea

# buildpack-deps:buster-scm - because for now we need ssh-keyscan
FROM buildpack-deps@sha256:07e999f2b4c56d4a9e8e5be86f2e2d865c22e6786e0322f7316bef4a3f65765f

RUN mkdir /runbin

COPY --from=stage1 /go/gitea /runbin
COPY ./docker/cmd_gitea/playwithgo-entrypoint.sh /playwithgo-entrypoint.sh

ENTRYPOINT ["/playwithgo-entrypoint.sh"]
