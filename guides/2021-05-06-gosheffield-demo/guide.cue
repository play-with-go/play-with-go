// script.cue
package guide

import "github.com/play-with-go/preguide"

Defs: {
	script:     "script.sh"
	scriptpath: "/home/gopher/\(script)"
}

Steps: create_script: preguide.#Upload & {
	Target: Defs.scriptpath
	Source: """
		echo "Hello, world!"

		"""
}

Steps: run_script: preguide.#Command & {
	Source: """
		bash \(Defs.scriptpath)
		"""
}

Scenarios: go115: preguide.#Scenario & {
	Description: "Go 1.15"
}

Terminals: term1: preguide.#Terminal & {
	Description: "The main terminal"
	Scenarios: go115: Image: _#go119LatestImage
}
