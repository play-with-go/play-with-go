package out

Terminals: [{
	Name:        "term1"
	Description: "The main terminal"
	Scenarios: {
		go119: {
			Image: "playwithgo/go1.19.1:6d8215b3a5eda6d3bcf338c58a26194abe18b4cd"
		}
	}
}]
Scenarios: [{
	Name:        "go119"
	Description: "Go 1.15"
}]
Networks: ["playwithgo_pwg"]
Env: []
Steps: {
	goversion: {
		StepType: 1
		Name:     "goversion"
		Order:    0
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go version"
			ExitCode: 0
			Output: """
				go version go1.19.1 linux/amd64

				"""
		}]
	}
	pwd_home: {
		StepType: 1
		Name:     "pwd_home"
		Order:    1
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "pwd"
			ExitCode: 0
			Output: """
				/home/gopher

				"""
		}]
	}
	mkdir_hello: {
		StepType: 1
		Name:     "mkdir_hello"
		Order:    2
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "mkdir /home/gopher/hello"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "cd /home/gopher/hello"
			ExitCode: 0
			Output:   ""
		}]
	}
	create_hello: {
		StepType: 2
		Name:     "create_hello"
		Order:    3
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package main

			import "fmt"

			func main() {
			\tfmt.Println("Hello, World!")
			}

			"""
		Target: "/home/gopher/hello/hello.go"
	}
	run_hello: {
		StepType: 1
		Name:     "run_hello"
		Order:    4
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go run hello.go"
			ExitCode: 0
			Output: """
				Hello, World!

				"""
		}]
	}
	update_hello: {
		StepType: 2
		Name:     "update_hello"
		Order:    5
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 3
			Pre: """
				package main

				import "fmt"

				func main() {
				\tfmt.Println("Hello, World!")
				}

				"""
		}
		Source: """
			package main

			import "fmt"

			import "rsc.io/quote"

			func main() {
			\tfmt.Println(quote.Go())
			}

			"""
		Target: "/home/gopher/hello/hello.go"
	}
	gomodinit: {
		StepType: 1
		Name:     "gomodinit"
		Order:    6
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go mod init hello"
			ExitCode: 0
			Output: """
				go: creating new go.mod: module hello
				go: to add module requirements and sums:
				\tgo mod tidy

				"""
		}]
	}
	gogetquote: {
		StepType: 1
		Name:     "gogetquote"
		Order:    7
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go get rsc.io/quote@v1.5.2"
			ExitCode: 0
			Output: """
				go: downloading rsc.io/quote v1.5.2
				go: downloading rsc.io/sampler v1.3.0
				go: downloading golang.org/x/text v0.0.0-20170915032832-14c0d48ead0c
				go: added golang.org/x/text v0.0.0-20170915032832-14c0d48ead0c
				go: added rsc.io/quote v1.5.2
				go: added rsc.io/sampler v1.3.0

				"""
		}]
	}
	run_hello_again: {
		StepType: 1
		Name:     "run_hello_again"
		Order:    8
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go run hello.go"
			ExitCode: 0
			Output: """
				Don't communicate by sharing memory, share memory by communicating.

				"""
		}]
	}
}
Hash: "22d44d4092b52269a9225228ea2e3a33bbb0b27545b941917b905f36535c5c4c"
Delims: ["{{{", "}}}"]
