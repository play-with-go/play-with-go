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

Terminals: term1: preguide.#Guide.#Terminal & {
	Description: "The main terminal"
	Scenarios: go115: Image: "playwithgo/go1.15@sha256:ec830fd226bdf40efd20d6d12a100f3176bc3d86b7e01c8772a7b7434306ffd4"
}

Steps: create_module: en: preguide.#Command & {Source: """
mkdir \(Defs.mod1)
cd \(Defs.mod1)
git init
git remote add origin https://play-with-go.dev/userguides/{{.REPO1}}.git
go mod init play-with-go.dev/userguides/{{.REPO1}}
"""}

Steps: create_readme: en: preguide.#Upload & {Target: Defs.mod1 + "/README.md", Source: """
## `play-with-go.dev/userguides/{{.REPO1}}`
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
git push -u origin master
"""}

Steps: use_module: en: preguide.#Command & {Source: """
mkdir \(Defs.mod2)
cd \(Defs.mod2)
go mod init mod.com
go get play-with-go.dev/userguides/{{.REPO1}}
go run play-with-go.dev/userguides/{{.REPO1}}
"""}
