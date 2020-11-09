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
		PREGUIDE_DEBUG:                     true
		PREGUIDE_SKIP_CACHE:                true
		PLAYWITHGODEV_CONTRIBUTOR_USER:     "playwithgopher_github"
		PLAYWITHGODEV_CONTRIBUTOR_PASSWORD: "${{ secrets.PLAYWITHGODEV_CONTRIBUTOR_PASSWORD }}"
		PLAYWITHGOPHER_GITHUB_PAT:          "${{ secrets.PLAYWITHGOPHER_GITHUB_PAT }}"
	}

	jobs: test: {
		strategy: {
			"fail-fast": false
			matrix: {
				go_version: ["1.15.2"]
			}
		}
		"runs-on": "${{ matrix.os }}"
		steps: [
			{
				name: "Checkout code"
				uses: "actions/checkout@v2"
			},
			{
				name: "Install Go"
				uses: "actions/setup-go@v2"
				with: "go-version": "${{ matrix.go_version }}"
			},
			{
				name: "Pre-download specific modules"
				run:  "go mod download github.com/play-with-go/preguide github.com/play-with-go/gitea"
			},
			{
				name: "mac CI setup"
				run:  "./_scripts/macCISetup.sh"
				if:   "${{ matrix.os == 'macos-latest' }}"
			},
			{
				name: "Ensure docker setup"
				run:  "./_scripts/ensureDocker.sh"
			},
			{
				name: "Env setup"
				run:  "./_scripts/env.sh github"
			},
			{
				name: "docker-compose build"
				run:  "./_scripts/dc.sh build"
			},
			{
				name: "Start gitea services"
				run:  "./_scripts/dc.sh up -d cmd_gitea"
			},
			{
				name: "Verify"
				run:  "go mod verify"
			},
			{
				name: "Re-generate guides"
				run:  "_scripts/generateGuides.sh"
			},
			{
				name:                "Race check re-generating guides"
				run:                 "go run -race github.com/play-with-go/preguide/cmd/preguide gen -out ../_posts"
				"working-directory": "./guides"
				if:                  "${{ github.event_name == 'schedule' }}"
			},
			{
				name: "Re-generate everything else"
				run:  "_scripts/generateEverythingElse.sh"
			},
			{
				name: "Tidy"
				run:  "go mod tidy"
			},
			{
				name: "Verify commit is clean"
				run:  "test -z \"$(git status --porcelain)\" || (git status; git diff; false)"
			},
			{
				name: "Publish site"
				run:  "_scripts/publishSite.sh"
			},
		]
	}
}

test: {
	name: "Test"
	#testWorkflow
	on: {
		push: branches: ["main"]
		pull_request: branches: ["**"]
		schedule: [{cron: "0 9 * * *"}]
	}
	jobs: test: strategy: matrix: os: ["ubuntu-latest"]
}

testmac: {
	name: "TestMac"
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
