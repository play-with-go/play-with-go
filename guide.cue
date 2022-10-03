package guide

import (
	"strings"

	"github.com/play-with-go/preguide"
)

Networks: *["playwithgo_pwg"] | [...string]

Delims: ["{{{", "}}}"]

_#dockerCommit: ":6d8215b3a5eda6d3bcf338c58a26194abe18b4cd"

_#installGo:           "playwithgo/installgo1.19.1\(_#dockerCommit)"
_#go119LatestVersion:  "go1.19.1"
_#go119LatestImage:    "playwithgo/go1.19.1\(_#dockerCommit)"
_#cuego119LatestImage: "playwithgo/cue_v0.4.3_go1.19.1\(_#dockerCommit)"

_#golangToolsLatest: "v0.1.13-0.20220917004541-4d18923f060e"

_#StablePsuedoversionSuffix: "20060102150405-abcedf12345"

_#goVersionSanitisers: [{
	Pattern:     #"linux\/.+(?:\n$)"#
	Replacement: "linux/amd64"
}]

_#goVersionMSanitisers: [
	{
		Pattern:     #"(?ms)^\s+build\s.*(?:\n)"#
		Replacement: ""
	},
	{
		Pattern:     #"(?m)\s+(?:$)"#
		LineWise:    true
		Replacement: ""
	},
]

_#goGetComparators: [
	{Pattern: #"(pkg/mod/cache/vcs/)[0-9a-f]+"#},
]

_#goTestSanitisers: []

_#goTestComparators: [
	{Pattern: #"^( *--- (PASS|FAIL): .+\()\d+(\.\d+)?s\)"#, LineWise: true},
	{Pattern: #"^((FAIL|ok  )\t.+\t)\d+(\.\d+)?s$"#, LineWise:        true},
]

_#goTestBenchSanitisers: [
	{Pattern: #"(?m)^goos: .*\ngoarch: .*\n"#, Replacement: "goos: linux\ngoarch: amd64\n"},
	{Pattern: #"(?m)^cpu: .*\n"#, Replacement:              ""},
]

_#goTestBenchComparators: [
	for _, v in _#goTestComparators {v},
	{Pattern: #"^([^\s]+)\s+\d+\s+\d+(\.\d+)? ns/op$"#, LineWise: true},
]

_#goEnvSanitiers: [
	{Pattern: #"(?m)^GOGCCFLAGS=.*\n"#, Replacement: ""},
	{Pattern: #"(?m)^GOAMD64=.*\n"#, Replacement:    ""},
	{Pattern: #"^(GOTOOLDIR=.*/)[^/]*"#, LineWise:   true, Replacement: #"${1}linux_amd64""#},
	{Pattern: #"^(GOOS=).*"#, LineWise:              true, Replacement: #"${1}"linux""#},
	{Pattern: #"^(GO(HOST)?ARCH=).*"#, LineWise:     true, Replacement: #"${1}"amd64""#},
]

// Set default go version sanitisers
Steps: [string]: *(preguide.#Command & {
	Stmts: [...*{
		Cmd:        _#commonDefs.cmdgo.version
		Sanitisers: _#goVersionSanitisers
	} | _]
}) | _

// Set default go env sanitisers
Steps: [string]: *(preguide.#Command & {
	Stmts: [...*{
		Cmd:        _#commonDefs.cmdgo.env
		Sanitisers: _#goEnvSanitiers
	} | _]
}) | _

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
		branch:   "git branch"
		checkout: "git checkout"
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
	Stmts:           """
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
