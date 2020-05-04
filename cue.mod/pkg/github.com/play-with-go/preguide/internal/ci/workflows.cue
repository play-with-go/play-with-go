package ci

import "github.com/SchemaStore/schemastore/src/schemas/json"

workflowsDir: *"./" | string @tag(workflowsDir)
scriptsDir:   *"./" | string @tag(scriptsDir)

test: json.#Workflow & {
	name: "Go"
	env: {
		PREGUIDE_IMAGE_OVERRIDE:   "playwithgo/go1.14.3@sha256:6289a34af0112146e551790d9f2a36622e083600752a02d36f1ad1f9e1389382"
		PREGUIDE_PRESTEP_DOCKEXEC: "buildpack-deps@sha256:ec0e9539673254d0cb1db0de347905cdb5d5091df95330f650be071a7e939420"
		PREGUIDE_PULL_IMAGE:       "missing"
	}
	on: {
		push: branches: ["master"]
		pull_request: branches: ["**"]
	}
	jobs: test: {
		strategy: {
			"fail-fast": false
			matrix: {
				os: ["ubuntu-latest"]
				go_version: ["go1.14.2"]
			}
		}
		"runs-on": "${{ matrix.os }}"
		steps: [{
			name: "Checkout code"
			uses: "actions/checkout@722adc63f1aa60a57ec37892e133b1d319cae598"
		}, {
			name: "Install Go"
			uses: "actions/setup-go@78bd24e01a1a907f7ea3e614b4d7c15e563585a8"
			with: "go-version": "${{ matrix.go-version }}"
		}, {
			name: "Verify"
			run:  "go mod verify"
		}, {
			name: "Generate"
			run:  "go generate ./..."
		}, {
			name: "Test"
			run:  "go test ./..."
		}, {
			name: "Tidy"
			run:  "go mod tidy"
		}, {
			name: "Verify commit is clean"
			run:  "test -z \"$(git status --porcelain)\" || (git status; git diff; false)"
		}]
	}
}
