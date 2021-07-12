package guide

import (
	"github.com/play-with-go/preguide"
)

Defs: {
	_#commonDefs
	fib:         "fib"
	fib_vcs:     "https://\(fib_mod).git"
	fib_mod:     "{{{.FIB}}}"
	fib_dir:     "/home/gopher/\(fib)"
	fib_go:      "\(fib).go"
	fib_test_go: "\(fib)_test.go"
}

Scenarios: go115: preguide.#Scenario & {
	Description: "Go 1.15"
}

Terminals: term1: preguide.#Terminal & {
	Description: "The main terminal"
	Scenarios: go115: Image: _#go115LatestImage
}

Steps: goversion: preguide.#Command & {
	Source: """
		go version
		"""
}

Steps: mkdir_fib: preguide.#Command & {
	Source: """
		mkdir \(Defs.fib_dir)
		cd \(Defs.fib_dir)
		"""
}

Steps: gomodinit_fib: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.modinit) \(Defs.fib)
		"""
}

Steps: create_fib_go: preguide.#Upload & {
	Target: "\(Defs.fib_dir)/\(Defs.fib_go)"
	Source: #"""
		package \#(Defs.fib)

		func Fib(n int) int {
			if n < 2 {
				return n
			}
			return Fib(n-1) + Fib(n-2)
		}

		"""#
}

Steps: create_fib_test_go: preguide.#Upload & {
	Target: "\(Defs.fib_dir)/\(Defs.fib_test_go)"
	Source: #"""
		package \#(Defs.fib)

		import "testing"

		func BenchmarkFib10(b *testing.B) {
			// run the Fib function b.N times
			for n := 0; n < b.N; n++ {
				Fib(10)
			}
		}

		"""#
}

Steps: fib_go_test_bench: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.test) -bench=.
		"""
}
