package guide

import (
	"github.com/play-with-go/gitea"
	"github.com/play-with-go/preguide"
)

Defs: {
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

Scenarios: go115: preguide.#Scenario & {
	Description: "Go 1.15"
}

Terminals: term1: preguide.#Terminal & {
	Description: "The main terminal"
	Scenarios: go115: Image: #go115LatestImage
}

Steps: create_module: en: preguide.#Command & {
	Source: """
		mkdir \(Defs.mod1_dir)
		cd \(Defs.mod1_dir)
		git init
		git remote add origin https://\(Defs.mod1_path).git
		go mod init \(Defs.mod1_path)
		"""
}

Steps: create_readme: en: preguide.#Upload & {
	Target: Defs.mod1_dir + "/README.md"
	Source: """
		## `\(Defs.mod1_path)`
		"""
}

Steps: create_main: en: preguide.#Upload & {
	Target: Defs.mod1_dir + "/main.go"
	Source: """
		package main

		import "fmt"

		func main() {
			fmt.Println("Hello, world!")
		}

		"""
}

Steps: commit_and_push: en: preguide.#Command & {
	Source: """
		git add -A
		git commit -m "Initial commit"
		git push -u origin main
		"""
}

Steps: use_module: en: preguide.#Command & {
	Source: """
		mkdir \(Defs.mod2_dir)
		cd \(Defs.mod2_dir)
		go mod init mod.com
		go get \(Defs.mod1_path)
		go run \(Defs.mod1_path)
		"""
}
