package guide

import (
	"github.com/play-with-go/preguide"
	"github.com/play-with-go/gitea"
)

Defs: {
	readmetxt: "/home/gopher/readme.txt"
}

Presteps: [gitea.#PrestepNewUser & {
	Args: {
		Repos: [
			{Var: "REPO1", Pattern: "mod1*"},
		]
	}
}]

Scenarios: go115: preguide.#Scenario & {
	Description: "Go 1.15"
}

Terminals: term1: preguide.#Terminal & {
	Description: "The main terminal"
	Scenarios: go115: Image: #go115LatestImage
}

Steps: echo_hello: en: preguide.#Command & {
	Source: """
		echo "Hello, world!"
		"""
}

Steps: multiple_commands: en: preguide.#Command & {
	Source: """
		echo "Hello"
		echo "Gopher!"
		"""
}

Steps: upload_readme: en: preguide.#Upload & {
	Target: Defs.readmetxt
	Source: """
		This is \(Defs.readmetxt).

		Hello, gopher!

		"""
}

Steps: upload_readme_again: en: preguide.#Upload & {
	Target:   Defs.readmetxt
	Renderer: preguide.#RenderDiff & {
		Pre: Steps.upload_readme.en.Source
	}
	Source: """
		This is \(Defs.readmetxt).

		Hello, gopher!

		We made a change!

		"""
}

Steps: cat_readme: en: preguide.#Command & {
	Source: """
		cat \(Defs.readmetxt)
		"""
}

Steps: whoami: en: preguide.#Command & {
	Source: """
		whoami
		pwd
		"""
}
