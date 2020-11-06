package out

Terminals: [{
	Description: "The main terminal"
	Scenarios: {
		go115: {
			Image: "playwithgo/go1.15.3@sha256:0212016958cbedb4297dd05407256f3f92dbbac4dd7f5ccf514117e79c6c92d2"
		}
	}
	Name: "term1"
}]
Scenarios: [{
	Description: "Go 1.15"
	Name:        "go115"
}]
Networks: ["playwithgo_pwg"]
Env: []
Steps: {
	run_hello_again: {
		Stmts: [{
			Output: """
				Don't communicate by sharing memory, share memory by communicating.

				"""
			ExitCode: 0
			CmdStr:   "go run hello.go"
			Negated:  false
		}]
		Order:           8
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "run_hello_again"
	}
	gogetquote: {
		Stmts: [{
			Output: """
				go: downloading rsc.io/quote v1.5.2
				go: downloading rsc.io/sampler v1.3.0
				go: downloading golang.org/x/text v0.0.0-20170915032832-14c0d48ead0c

				"""
			ExitCode: 0
			CmdStr:   "go get rsc.io/quote@v1.5.2"
			Negated:  false
		}]
		Order:           7
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gogetquote"
	}
	update_hello: {
		Order: 5
		Source: """
			package main

			import "fmt"

			import "rsc.io/quote"

			func main() {
			\tfmt.Println(quote.Go())
			}

			"""
		Renderer: {
			Pre: """
				package main

				import "fmt"

				func main() {
				\tfmt.Println("Hello, World!")
				}

				"""
			RendererType: 3
		}
		Language: "go"
		Target:   "/home/gopher/hello/hello.go"
		Terminal: "term1"
		StepType: 2
		Name:     "update_hello"
	}
	run_hello: {
		Stmts: [{
			Output: """
				Hello, World!

				"""
			ExitCode: 0
			CmdStr:   "go run hello.go"
			Negated:  false
		}]
		Order:           4
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "run_hello"
	}
	create_hello: {
		Order: 3
		Source: """
			package main

			import "fmt"

			func main() {
			\tfmt.Println("Hello, World!")
			}

			"""
		Renderer: {
			RendererType: 1
		}
		Language: "go"
		Target:   "/home/gopher/hello/hello.go"
		Terminal: "term1"
		StepType: 2
		Name:     "create_hello"
	}
	mkdir_hello: {
		Stmts: [{
			Output:   ""
			ExitCode: 0
			CmdStr:   "mkdir /home/gopher/hello"
			Negated:  false
		}, {
			Output:   ""
			ExitCode: 0
			CmdStr:   "cd /home/gopher/hello"
			Negated:  false
		}]
		Order:           2
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "mkdir_hello"
	}
	pwd_home: {
		Stmts: [{
			Output: """
				/home/gopher

				"""
			ExitCode: 0
			CmdStr:   "pwd"
			Negated:  false
		}]
		Order:           1
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "pwd_home"
	}
	goversion: {
		Stmts: [{
			Output: """
				go version go1.15.3 linux/amd64

				"""
			ExitCode: 0
			CmdStr:   "go version"
			Negated:  false
		}]
		Order:           0
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "goversion"
	}
	gomodinit: {
		Stmts: [{
			Output: """
				go: creating new go.mod: module hello

				"""
			ExitCode: 0
			CmdStr:   "go mod init hello"
			Negated:  false
		}]
		Order:           6
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gomodinit"
	}
}
Hash: "6051c09d53857b06e5935ba5186d63286017e3d087b6310fe5eb48d9a66827be"
Delims: ["{{{", "}}}"]
