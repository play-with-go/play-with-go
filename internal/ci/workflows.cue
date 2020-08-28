package ci

import "github.com/SchemaStore/schemastore/src/schemas/json"

test: json.#Workflow & {
	on: {
		push: branches: ["master"]
		pull_request: branches: ["**"]
	}

	env: {
		PLAYWITHGODEV_GITHUB_USER: "playwithgopher"
		PLAYWITHGODEV_GITHUB_PAT:  "${{ secrets.PLAYWITHGODEV_GITHUB_PAT }}"
	}

	name: "Test"
	jobs: test: {
		strategy: {
			"fail-fast": false
			matrix: {
				os: ["ubuntu-latest"]
				go_version: ["1.15"]
			}
		}
		"runs-on": "${{ matrix.os }}"
		steps: [{
			name: "Setup netrc"
			run:  #"echo -e "machine github.com\nlogin $PLAYWITHGODEV_GITHUB_USER\npassword $PLAYWITHGODEV_GITHUB_PAT\n\nmachine api.github.com\nlogin $PLAYWITHGODEV_GITHUB_USER\npassword $PLAYWITHGODEV_GITHUB_PAT\n" > ~/.netrc"#
		}, {
			name: "Checkout code"
			uses: "actions/checkout@v2"
		}, {
			name: "Install Go"
			uses: "actions/setup-go@v2"
			with: "go-version": "${{ matrix.go_version }}"
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

wip: json.#Workflow & {
	name: "WIP"
	on: {
		pull_request: {
			types: ["opened", "synchronize", "reopened", "edited"]
		}
	}
	jobs: wip: {
		env: {
			GITHUB_TOKEN: "${{ secrets.GITHUB_TOKEN }}"
		}
		"runs-on": "ubuntu-latest"
		steps: [{
			uses: "myitcv/wip@v1.0.0"
			with: {
				token: "${{ secrets.GITHUB_TOKEN }}"
			}
		}]
	}
}
