package guide

import (

	"github.com/play-with-go/preguide"
	"github.com/play-with-go/gitea"
)

Defs: {
	modname:     "hello"
	fullmodpath: "gopher.live/{{{.GITEA_USERNAME}}}/{{{.REPO1}}}"
	vcsurl:      "https://\(fullmodpath).git"
	readme:      "README.md"
	readmepath:  "/home/gopher/hello/\(readme)"
}

Presteps: [gitea.#PrestepNewUser & {
	Args: {
		Repos: [
			{Var: "REPO1", Pattern: Defs.modname},
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

Steps: whoami: en: preguide.#Command & {
	Source: """
		whoami
		pwd
		"""
}

Steps: echo_hello: en: preguide.#Command & {
	Source: """
		echo "Hello, world!"
		"""
}

Steps: multiple_commands: en: preguide.#Command & {
	Source: """
		mkdir \(Defs.modname)
		cd \(Defs.modname)
		"""
}

Steps: upload_readme: en: preguide.#Upload & {
	Target: Defs.readmepath
	Source: """
		This is \(Defs.readme).

		Hello, gopher!

		"""
}

Steps: upload_readme_again: en: preguide.#Upload & {
	Target:   Defs.readmepath
	Renderer: preguide.#RenderDiff & {
		Pre: Steps.upload_readme.en.Source
	}
	Source: """
		This is \(Defs.readme).

		Hello, gopher!

		We made a change!

		"""
}

Steps: cat_readme: en: preguide.#Command & {
	Source: """
		cat \(Defs.readme)
		"""
}

Steps: gitinit: en: preguide.#Command & {
	Source: """
		git init -q
		git remote add origin \(Defs.vcsurl)
		"""
}

Steps: gitadd: en: preguide.#Command & {
	Source: """
		git add -A
		git commit -am 'Initial commit'
		"""
}

Steps: gitpush: en: preguide.#Command & {
	Source: """
		git push origin main
		"""
}
