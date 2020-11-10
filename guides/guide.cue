package guide

import (
	"strings"

	"github.com/play-with-go/preguide"
)

Networks: *["playwithgo_pwg"] | [...string]

Delims: ["{{{", "}}}"]

_#go115LatestImage: "playwithgo/go1.15.3@sha256:0212016958cbedb4297dd05407256f3f92dbbac4dd7f5ccf514117e79c6c92d2"
_#go116LatestImage: "playwithgo/go1.16-tip@sha256:4f6f3820ad3d6c30b623eabe688bfd073eeb4a52c284c80b3e6bc4a3b8cded2a"

_#golangToolsLatest: "v0.0.0-20201105220310-78b158585360"

_#StablePsuedoversionSuffix: "20060102150405-abcedf12345"

_#commonDefs: {
	cmdgo: {
		modinit:  "go mod init"
		modedit:  "go mod edit"
		modtidy:  "go mod tidy"
		test:     "go test"
		run:      "go run"
		get:      "go get"
		list:     "go list"
		install:  "go install"
		generate: "go generate"
		env:      "go env"
		build:    "go build"
		vlatest:  "latest"
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
