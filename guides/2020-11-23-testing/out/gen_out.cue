package out

Terminals: [{
	Name:        "term1"
	Description: "The main terminal"
	Scenarios: {
		go115: {
			Image: "playwithgo/go1.15.5@sha256:e26150265392c264f720f524a6402092efffca9afd475b11512afff0aa813bc6"
		}
	}
}]
Scenarios: [{
	Name:        "go115"
	Description: "Go 1.15"
}]
Networks: ["playwithgo_pwg"]
Env: []
FilenameComment: false
Steps: {
	goversion: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "goversion"
		Order:           0
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go version"
			ExitCode: 0
			Output: """
				go version go1.15.5 linux/amd64

				"""
			ComparisonOutput: """
				go version go1.15.5 linux/amd64

				"""
		}]
	}
	mkdir_fib: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "mkdir_fib"
		Order:           1
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "mkdir /home/gopher/fib"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cd /home/gopher/fib"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	gomodinit_fib: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gomodinit_fib"
		Order:           2
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go mod init fib"
			ExitCode: 0
			Output: """
				go: creating new go.mod: module fib

				"""
			ComparisonOutput: """
				go: creating new go.mod: module fib

				"""
		}]
	}
	create_fib_go: {
		StepType: 2
		Name:     "create_fib_go"
		Order:    3
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package fib

			func Fib(n int) int {
			\tif n < 2 {
			\t\treturn n
			\t}
			\treturn Fib(n-1) + Fib(n-2)
			}

			"""
		Target: "/home/gopher/fib/fib.go"
	}
	create_fib_test_go: {
		StepType: 2
		Name:     "create_fib_test_go"
		Order:    4
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package fib

			import "testing"

			func BenchmarkFib10(b *testing.B) {
			\t// run the Fib function b.N times
			\tfor n := 0; n < b.N; n++ {
			\t\tFib(10)
			\t}
			}

			"""
		Target: "/home/gopher/fib/fib_test.go"
	}
	fib_go_test_bench: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "fib_go_test_bench"
		Order:           5
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go test -bench=."
			ExitCode: 0
			Output: """
				goos: linux
				goarch: amd64
				pkg: fib
				BenchmarkFib10 \t 3039295\t       376 ns/op
				PASS
				ok  \tfib\t1.546s

				"""
			ComparisonOutput: """
				goos: linux
				goarch: amd64
				pkg: fib
				BenchmarkFib10 NN N ns/op
				PASS
				ok  \tfib\tN.NNs

				"""
		}]
	}
}
Hash: "79a2ca0e0948297115c1c717142745368aa6f5f9e732b4eec4eee49767a4b8a3"
Delims: ["{{{", "}}}"]
