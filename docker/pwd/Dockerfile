# golang:1.19.1
FROM golang@sha256:2d17ffd12a2cdb25d4a633ad25f8dc29608ed84f31b3b983427d825280427095 AS stage1

ENV GOCACHE=/root/.cache/go/gocache
ENV GOMODCACHE=/root/.cache/go/gomodcache
ENV CGO_ENABLED=0
ENV GOPATH=

COPY go.mod go.sum .

RUN --mount=type=cache,target=/root/.cache/go go build github.com/play-with-docker/play-with-docker

# golang:1.19.1
#
# TODO: move this to a more slimline image that has ssh etc
FROM golang@sha256:2d17ffd12a2cdb25d4a633ad25f8dc29608ed84f31b3b983427d825280427095

RUN mkdir /runbin

COPY --from=stage1 /go/play-with-docker /runbin/pwd
COPY ./docker/pwd/playwithgo-entrypoint.sh /playwithgo-entrypoint.sh

ENTRYPOINT ["/playwithgo-entrypoint.sh"]
