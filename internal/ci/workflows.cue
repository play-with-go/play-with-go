package ci

import "github.com/SchemaStore/schemastore/src/schemas/json"

_#workflows: [...{file: string, schema: json.#Workflow}]
_#workflows: [
	{file: "test.yml", schema:    test},
	{file: "testmac.yml", schema: testmac},
	{file: "wip.yml", schema:     wip},
]

#testWorkflow: json.#Workflow & {
	env: {
		PREGUIDE_SKIP_CACHE:       true
		PLAYWITHGODEV_GITHUB_USER: "playwithgopher"
		PLAYWITHGODEV_GITHUB_PAT:  "${{ secrets.PLAYWITHGODEV_GITHUB_PAT }}"
	}

	name: "Test"
	jobs: test: {
		strategy: {
			"fail-fast": false
			matrix: {
				go_version: ["1.15.2"]
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
			name: "Pre-download specific modules"
			run:  "go mod download github.com/play-with-go/preguide github.com/play-with-go/gitea"
		}, {
			name: "mac CI setup"
			run:  "./_scripts/macCISetup.sh"
			if:   "${{ matrix.os == 'macos-latest' }}"
		}, {
			name: "Ensure docker setup"
			run:  "./_scripts/ensureDocker.sh"
		}, {
			name: "Setup mkcert"
			run:  "./_scripts/setupmkcert.sh"
		}, {
			name: "Env setup"
			run:  "./_scripts/env.sh github"
		}, {
			name: "docker-compose build"
			run:  "./_scripts/dc.sh build"
		}, {
			name: "Start gitea services"
			run:  "./_scripts/dc.sh up -d nginx gitea cmd_gitea"
		}, {
			name: "Setup"
			run:  "./_scripts/setup.sh"
		}, {
			name: "Verify"
			run:  "go mod verify"
		}, {
			name: "Re-generate guides"
			run:  "_scripts/generateGuides.sh"
		}, {
			name: "Re-generate everything else"
			run:  "_scripts/generateEverythingElse.sh"
		}, {
			name: "Tidy"
			run:  "go mod tidy"
		}, {
			name: "Verify commit is clean"
			run:  "test -z \"$(git status --porcelain)\" || (git status; git diff; false)"
		}]
	}
}

test: {
	#testWorkflow
	on: {
		push: branches: ["main"]
		pull_request: branches: ["**"]
	}
	jobs: test: strategy: matrix: os: ["ubuntu-latest"]
}

testmac: {
	#testWorkflow
	on: schedule: [{cron: "0 9 * * *"}]
	jobs: test: strategy: matrix: os: ["macos-latest"]
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
