package guide

import (
	"github.com/play-with-go/preguide"
)

Defs: {
	quote:     "rsc.io/quote"
	quotev:    "v1.5.2"
	hello_dir: "/home/gopher/hello"
	hello_go:  "hello.go"
	gomodinit: "go mod init"
	hellomod:  "hello"
}

Scenarios: go115: preguide.#Scenario & {
	Description: "Go 1.15"
}

Terminals: term1: preguide.#Terminal & {
	Description: "The main terminal"
	Scenarios: go115: Image: #go115LatestImage
}

Steps: goversion: en: preguide.#Command & {
	Source: """
		go version
		"""
}

Steps: pwd_home: en: preguide.#Command & {
	Source: """
		pwd
		"""
}

Steps: mkdir_hello: en: preguide.#Command & {
	Source: """
		mkdir \(Defs.hello_dir)
		cd \(Defs.hello_dir)
		"""
}

Steps: create_hello: en: preguide.#Upload & {
	Target: "\(Defs.hello_dir)/\(Defs.hello_go)"
	Source: """
		package main

		import "fmt"

		func main() {
			fmt.Println("Hello, World!")
		}
		"""
}

Steps: run_hello: en: preguide.#Command & {
	Source: """
		go run \(Defs.hello_go)
		"""
}

Steps: update_hello: en: preguide.#Upload & {
	Target:   "\(Defs.hello_dir)/\(Defs.hello_go)"
	Renderer: preguide.#RenderDiff & {
		Pre: Steps.create_hello.en.Source
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

Steps: gomodinit: en: preguide.#Command & {
	Source: """
		\(Defs.gomodinit) \(Defs.hellomod)
		"""
}

Steps: gogetquote: en: preguide.#Command & {
	Source: """
		go get rsc.io/quote@v1.5.2
		"""
}

Steps: run_hello_again: en: preguide.#Command & {
	Source: """
		go run \(Defs.hello_go)
		"""
}
