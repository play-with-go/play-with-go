package ci

import "github.com/SchemaStore/schemastore/src/schemas/json"

#workflows: [...{file: string, schema: json.#Workflow}]
#workflows: [
	{file: "test.yml", schema: test},
]

_#latestUbuntu: "ubuntu-20.04"
_#latestGo:     "1.19.1"

#testWorkflow: json.#Workflow & {
	env: {
		DOCKER_HUB_USER:                    "playwithgopher"
		DOCKER_HUB_TOKEN:                   "${{ secrets.DOCKER_HUB_TOKEN }}"
		PLAYWITHGODEV_CONTRIBUTOR_USER:     "playwithgopher_github"
		PLAYWITHGODEV_CONTRIBUTOR_PASSWORD: "${{ secrets.PLAYWITHGODEV_CONTRIBUTOR_PASSWORD }}"
		PLAYWITHGOPHER_GITHUB_PAT:          "${{ secrets.PLAYWITHGOPHER_GITHUB_PAT }}"
	}

	jobs: test: {
		strategy: {
			"fail-fast": false
			matrix: {
				go_version: [_#latestGo]
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
				name: "Verify"
				run:  "go mod verify"
			},
			{
				name: "Tidy"
				run:  "go mod tidy"
			},
			{
				name: "Run unity tests"
				run:  "go run github.com/cue-sh/unity/cmd/unity test"
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
				name: "Re-generate guides"
				run:  "_scripts/generateGuides.sh"
				env: {
					CGO_ENABLED:         "0"
					PREGUIDE_SKIP_CACHE: "true"
					PREGUIDE_PROGRESS:   "true"
				}
			},
			{
				name: "Re-generate everything else"
				run:  "_scripts/generateEverythingElse.sh"
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
		push: {
			branches: ["main"]
			tags: ["v*"]
		}
		pull_request: branches: ["**"]
		schedule: [{cron: "0 9 * * *"}]
	}
	jobs: test: strategy: matrix: os: [_#latestUbuntu]
}
