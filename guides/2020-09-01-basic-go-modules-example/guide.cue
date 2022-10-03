package guide

import (
	"github.com/play-with-go/gitea"
	"github.com/play-with-go/preguide"
)

Defs: {
	_#commonDefs
	mod1_name: "mod1"
	mod1_path: "{{{.REPO1}}}"
	mod1_dir:  "/home/gopher/\(mod1_name)"
	mod2_name: "mod2"
	mod2_dir:  "/home/gopher/\(mod2_name)"
}

Presteps: [gitea.#PrestepNewUser & {
	Args: {
		Repos: [
			{Var: "REPO1", Pattern: "\(Defs.mod1_name)"},
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

Steps: create_module: preguide.#Command & {
	Stmts: """
		mkdir \(Defs.mod1_dir)
		cd \(Defs.mod1_dir)
		\(Defs.git.init)
		\(Defs.git.remote) add origin https://\(Defs.mod1_path).git
		\(Defs.cmdgo.modinit) \(Defs.mod1_path)
		"""
}

Steps: create_readme: preguide.#Upload & {
	Target: Defs.mod1_dir + "/README.md"
	Source: """
		## `\(Defs.mod1_path)`
		"""
}

Steps: create_main: preguide.#Upload & {
	Target: Defs.mod1_dir + "/main.go"
	Source: """
		package main

		import "fmt"

		func main() {
			fmt.Println("Hello, world!")
		}

		"""
}

Steps: commit_and_push: preguide.#Command & {
	Stmts: """
		\(Defs.git.add) go.mod README.md main.go
		\(Defs.git.commit) -m "Initial commit"
		\(Defs.git.push) origin main
		"""
}

Steps: check_porcelain: preguide.#Command & {
	InformationOnly: true
	Stmts: """
		[ "$(git status --porcelain)" == "" ] || (git status && false)
		"""
}

Steps: use_module: preguide.#Command & {
	Stmts: """
		mkdir \(Defs.mod2_dir)
		cd \(Defs.mod2_dir)
		\(Defs.cmdgo.modinit) mod.com
		\(Defs.cmdgo.get) \(Defs.mod1_path)
		\(Defs.cmdgo.run) \(Defs.mod1_path)
		"""
}

Steps: mod1_pseudoversion: preguide.#Command & {
	InformationOnly: true
	Stmts: [{
		Cmd:           """
		\(Defs.cmdgo.list) -m -f {{.Version}} \(Defs.mod1_path)
		"""
		RandomReplace: "v0.0.0-\(_#StablePsuedoversionSuffix)"
	}]
}
