package guide

import (

	"github.com/play-with-go/preguide"
	"github.com/play-with-go/gitea"
)

Defs: {
	_#commonDefs
	modname:     "hello"
	fullmodpath: "{{{.REPO1}}}"
	vcsurl:      "https://\(fullmodpath).git"
	readme:      "README.md"
	readmepath:  "/home/gopher/hello/\(readme)"
	username:    "{{{.GITEA_USERNAME}}}"
}

Presteps: [gitea.#PrestepNewUser & {
	Args: {
		Repos: [
			{Var: "REPO1", Pattern: Defs.modname},
		]
	}
}]

Scenarios: go119: preguide.#Scenario & {
	Description: "Go 1.15"
}

Terminals: term1: preguide.#Terminal & {
	Description: "The main terminal"
	Scenarios: go119: Image: _#go119LatestImage
}

Steps: whoami: preguide.#Command & {
	Stmts: """
		whoami
		pwd
		"""
}

Steps: echo_hello: preguide.#Command & {
	Stmts: """
		echo '*** !!! CLICK ME !!! ***'
		"""
}

Steps: multiple_commands: preguide.#Command & {
	Stmts: """
		mkdir \(Defs.modname)
		cd \(Defs.modname)
		"""
}

Steps: upload_readme: preguide.#Upload & {
	Target: Defs.readmepath
	Source: """
		This is \(Defs.readme).

		Hello, gopher!

		"""
}

Steps: upload_readme_again: preguide.#Upload & {
	Target:   Defs.readmepath
	Renderer: preguide.#RenderDiff & {
		Pre: Steps.upload_readme.Source
	}
	Source: """
		This is \(Defs.readme).

		Hello, gopher!

		We made a change!

		"""
}

Steps: cat_readme: preguide.#Command & {
	Stmts: """
		cat \(Defs.readme)
		"""
}

Steps: gitinit: preguide.#Command & {
	Stmts: """
		\(Defs.git.init)
		\(Defs.git.remote) add origin \(Defs.vcsurl)
		"""
}

Steps: gitadd: preguide.#Command & {
	Stmts: """
		\(Defs.git.add) README.md
		\(Defs.git.commit) -m 'Initial commit'
		"""
}

Steps: gitpush: preguide.#Command & {
	Stmts: """
		\(Defs.git.push) origin main
		"""
}
