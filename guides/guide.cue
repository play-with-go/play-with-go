package guide

import (
	"strings"

	"github.com/play-with-go/preguide"
)

Networks: *["playwithgo_pwg"] | [...string]

Delims: ["{{{", "}}}"]

_#installGo:          "playwithgo/installgo1.15.5@sha256:84d53427b7292d67cbb45fddebe2e5ae310c7d9cc8b8ea67c2738757f9069a15"
_#go115LatestVersion: "go1.15.5"
_#go115LatestImage:   "playwithgo/go1.15.5@sha256:2cc72c6bf72ce59de8aff52f7bbb0603926dbdd70473ec7f8b9f8310edf57ba4"
_#go116LatestImage:   "playwithgo/go1.16-tip@sha256:32d8ed6e153b937670343af5132bc62ac2b6ac2eb5ba82adc761775897f33f16"

_#golangToolsLatest: "v0.0.0-20201105220310-78b158585360"

_#StablePsuedoversionSuffix: "20060102150405-abcedf12345"

_#commonDefs: {
	pwg: {
		gopher_live: "gopher.live"
	}
	cmdgo: {
		modinit:     "go mod init"
		modedit:     "go mod edit"
		modtidy:     "go mod tidy"
		test:        "go test"
		run:         "go run"
		get:         "go get"
		list:        "go list"
		install:     "go install"
		generate:    "go generate"
		env:         "go env"
		help:        "go help"
		build:       "go build"
		version:     "go version"
		vlatest:     "latest"
		GO111MODULE: "GO111MODULE"
		GOPROXY:     "GOPROXY"
		GOPATH:      "GOPATH"
		GOBIN:       "GOBIN"
		GOENV:       "GOENV"
		GONOPROXY:   "GONOPROXY"
		GOSUMDB:     "GOSUMDB"
		GONOSUMDB:   "GONOSUMDB"
		GOPRIVATE:   "GOPRIVATE"
	}
	git: {
		add:      "git add"
		remote:   "git remote"
		init:     "git init -q"
		commit:   "git commit -q"
		push:     "git push -q"
		tag:      "git tag"
		revparse: "git rev-parse"
	}
	proxygolangorg: {
		waitforcache: "1m" // value passed to Unix sleep
	}
}

// _#waitForVersion: preguide.#Command & {
_#waitForVersion: preguide.#Command & {
	// time in seconds
	_#newversiontimeout: 120

	// number of times a version list must succeed
	_#retryversioncount: 10

	_#module: string
	_#versions: [...string]

	InformationOnly: true
	Source:          """
					(
					i=0
					j=0
					while true
					do
						x="$(go list -x -m -retracted -versions \(_#module))"
						echo "$x"
						if echo "$x" | \(strings.Join([ for v in _#versions {"grep \(v)"}], " | "))
						then
							j=$((j+1))
						else
							j=0
							i=$((i+1))
						fi
						if [ "$j" == "\(_#retryversioncount)" ]
						then
							break
						fi
						if [ "$i" == "\(_#newversiontimeout)" ]
						then
							exit 1
						fi
						sleep 1s
					done
					) > /dev/null 2>&1
					"""
}
