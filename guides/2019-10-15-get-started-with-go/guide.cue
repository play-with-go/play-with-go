package guide

import (
	"github.com/play-with-go/preguide"
)

Defs: {
	_#commonDefs
	quote:     "rsc.io/quote"
	quotev:    "v1.5.2"
	hello_dir: "/home/gopher/hello"
	hello_go:  "hello.go"
	hellomod:  "hello"
}

Scenarios: go119: preguide.#Scenario & {
	Description: "Go 1.15"
}

Terminals: term1: preguide.#Terminal & {
	Description: "The main terminal"
	Scenarios: go119: Image: _#go119LatestImage
}

Steps: goversion: preguide.#Command & {
	Stmts: [{
		Cmd: "go version"
	}]
}

Steps: pwd_home: preguide.#Command & {
	Stmts: """
		pwd
		"""
}

Steps: mkdir_hello: preguide.#Command & {
	Stmts: """
		mkdir \(Defs.hello_dir)
		cd \(Defs.hello_dir)
		"""
}

Steps: create_hello: preguide.#Upload & {
	Target: "\(Defs.hello_dir)/\(Defs.hello_go)"
	Source: """
		package main

		import "fmt"

		func main() {
			fmt.Println("Hello, World!")
		}

		"""
}

Steps: run_hello: preguide.#Command & {
	Stmts: """
		go run \(Defs.hello_go)
		"""
}

Steps: update_hello: preguide.#Upload & {
	Target:   "\(Defs.hello_dir)/\(Defs.hello_go)"
	Renderer: preguide.#RenderDiff & {
		Pre: Steps.create_hello.Source
	}
	Source: """
		package main

		import "fmt"

		import "rsc.io/quote"

		func main() {
			fmt.Println(quote.Go())
		}

		"""
}

Steps: gomodinit: preguide.#Command & {
	Stmts: """
		\(Defs.cmdgo.modinit) \(Defs.hellomod)
		"""
}

Steps: gogetquote: preguide.#Command & {
	Stmts: """
		go get rsc.io/quote@v1.5.2
		"""
}

Steps: run_hello_again: preguide.#Command & {
	Stmts: """
		go run \(Defs.hello_go)
		"""
}
