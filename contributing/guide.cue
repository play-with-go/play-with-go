package guide

import (
	"github.com/play-with-go/preguide"
)

Defs: {
	_#commonDefs
	playWithGoCommit: "simple_guide"
	myfirstguide:     "2020-11-25-myfirstguide"
}

Delims: ["{{{", "}}}"]

Scenarios: go115: preguide.#Scenario & {
	Description: "Go 1.15"
}

Terminals: term1: preguide.#Terminal & {
	Description: "The main terminal"
	Scenarios: go115: Image: "playwithgo/create-your-first-guide"
}

Steps: tool_versions: preguide.#Command & {Source: """
	docker version -f {{.Server.Version}}
	docker-compose version
	go version
	"""}

Steps: clone_play_with_go: preguide.#Command & {Source: """
	\(Defs.git.clone) https://github.com/play-with-go/play-with-go
	cd play-with-go
	git checkout \(Defs.playWithGoCommit)
	"""}
// git checkout -b myfirstguide \(Defs.playWithGoCommit)

// Steps: create_branch: preguide.#Command & {
//  Source: """
//  ./_scripts/dc.sh build
//  ./_scripts/dc.sh up -d
//  ./_scripts/generateGuides.sh
//  """
// }

// Steps: start_guide: preguide.#Command & {
//  Source: """
//  mkdir guides/\(Defs.myfirstguide)
//  """
// }

Steps: create_file: preguide.#Upload & {
	Target: "/home/gopher/play-with-go/blah.txt"
	Source: """
		Blah

		"""
}
