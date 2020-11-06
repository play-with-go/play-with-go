package guide

Networks: *["playwithgo_pwg"] | [...string]

Delims: ["{{{", "}}}"]

_#go115LatestImage: "playwithgo/go1.15.3@sha256:0212016958cbedb4297dd05407256f3f92dbbac4dd7f5ccf514117e79c6c92d2"
_#go116LatestImage: "playwithgo/go1.16-3ef8562c9c@sha256:10a860b1e127f7f4b1e0c5e8403347a643122aff6e94b1b51452f84827f5b79f"

_#golangToolsLatest: "v0.0.0-20201105220310-78b158585360"

_#StablePsuedoversionSuffix: "20060102150405-abcedf12345"

_#commonDefs: {
	cmdgo: _#cmdGo
}

_#cmdGo: {
	modinit:  "go mod init"
	modedit:  "go mod edit"
	modtidy:  "go mod tidy"
	test:     "go test"
	run:      "go run"
	get:      "go get"
	list:     "go list"
	install:  "go install"
	generate: "go generate"
}
