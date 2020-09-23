package guide

import (
	"github.com/play-with-go/gitea"
	"github.com/play-with-go/preguide"
)

Defs: {
	mod1: "/home/gopher/mod1"
	mod2: "/home/gopher/mod2"
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

Steps: create_module: en: preguide.#Command & {Source: """
mkdir \(Defs.mod1)
cd \(Defs.mod1)
git init
git remote add origin https://gopher.live/{{{.REPO1}}}.git
go mod init gopher.live/{{{.REPO1}}}
"""}

Steps: create_readme: en: preguide.#Upload & {Target: Defs.mod1 + "/README.md", Source: """
## `gopher.live/{{{.REPO1}}}`
"""}

Steps: create_main: en: preguide.#Upload & {Target: Defs.mod1 + "/main.go", Source: """
package main

import "fmt"

func main() {
	fmt.Println("Hello, world!")
}
"""}

Steps: commit_and_push: en: preguide.#Command & {Source: """
git add -A
git commit -m "Initial commit"
git push -u origin main
"""}

Steps: use_module: en: preguide.#Command & {Source: """
mkdir \(Defs.mod2)
cd \(Defs.mod2)
go mod init mod.com
go get gopher.live/{{{.REPO1}}}
go run gopher.live/{{{.REPO1}}}
"""}
