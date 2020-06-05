package ci

import "github.com/SchemaStore/schemastore/src/schemas/json"

test: json.#Workflow & {
	on: {
		push: branches: [
			"master",
		]
		pull_request: branches: [
			"**",
		]
	}

	env: {
		GOPRIVATE:           "github.com/play-with-go/*"
		PREGUIDE_SKIP_CACHE: "true"
		PREGUIDE_PULL_IMAGE: "missing"
	}

	name: "Go"
	jobs: test: {
		strategy: {
			"fail-fast": false
			matrix: {
				os: ["ubuntu-latest"]
				go_version: ["1.14.2"]
			}
		}
		"runs-on": "${{ matrix.os }}"
		steps: [{
			name: "Checkout code"
			uses: "actions/checkout@01aecccf739ca6ff86c0539fbc67a7a5007bbc81"
		}, {
			// v2.1.0
			name: "Install Go"
			uses: "actions/setup-go@78bd24e01a1a907f7ea3e614b4d7c15e563585a8" // v2.0.3
			with: "go-version": "${{ matrix.go_version }}"
		}, {
			name: "Setup netrc"
			run:  "echo -e \"machine github.com\\nlogin playwithgopher\\npassword ${{secrets.playwithgopherPAT}}\\n\\nmachine api.github.com\\nlogin playwithgopher\\npassword ${{secrets.playwithgopherPAT}}\\n\" > ~/.netrc"
		}, {
			name: "Start gitea"
			run:  "$(go list -f {{.Dir}} github.com/play-with-go/gitea)/setup.sh"
		}, {
			name: "Verify"
			run:  "go mod verify"
		}, {
			name: "Re-generate"
			run:  "go generate ./..."
		}, {
			name: "Tidy"
			run:  "go mod tidy"
		}, {
			name: "Verify commit is clean"
			run:  "test -z \"$(git status --porcelain)\" || (git status; git diff; false)"
		}]
	}
}
