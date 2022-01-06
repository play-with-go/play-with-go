# golang:1.19.1
FROM golang@sha256:2d17ffd12a2cdb25d4a633ad25f8dc29608ed84f31b3b983427d825280427095 AS stage1

ENV GOCACHE=/root/.cache/go/gocache
ENV GOMODCACHE=/root/.cache/go/gomodcache
ENV CGO_ENABLED=0
ENV GOPATH=

COPY go.mod go.sum .
COPY cmd/ ./cmd

RUN --mount=type=cache,target=/root/.cache/go go build -o cmd/controller/controller ./cmd/controller

# busybox
FROM busybox@sha256:ad9bd57a3a57cc95515c537b89aaa69d83a6df54c4050fcf2b41ad367bec0cd5

RUN mkdir /runbin

COPY --from=stage1 /go/cmd/controller/controller /runbin
COPY ./docker/controller/playwithgo-entrypoint.sh /playwithgo-entrypoint.sh
COPY ./prestep_conf.cue /start/
COPY ./guides /start/guides
COPY ./cue.mod /start/

ENTRYPOINT ["/playwithgo-entrypoint.sh"]
