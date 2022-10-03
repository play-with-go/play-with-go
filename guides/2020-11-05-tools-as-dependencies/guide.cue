package guide

import (
	"github.com/play-with-go/gitea"
	"github.com/play-with-go/preguide"
)

Presteps: [gitea.#PrestepNewUser & {
	Args: {
		Repos: [
			{Var: "PAINKILLER", Pattern: Defs.painkiller},
		]
	}
}]

Defs: {
	_#commonDefs
	painkiller:         "painkiller"
	painkiller_vcs:     "https://\(painkiller_mod).git"
	painkiller_mod:     "{{{.PAINKILLER}}}"
	painkiller_dir:     "/home/gopher/\(painkiller)"
	painkiller_go:      "\(painkiller).go"
	tools_constraint:   "tools"
	tools_go:           "\(tools_constraint).go"
	pilltype:           "Pill"
	stringer:           "stringer"
	stringer_pkg:       "golang.org/x/tools/cmd/\(stringer)"
	stringer_type_flag: "-type"
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

Steps: painkiller_go_mod_init: preguide.#Command & {
	Stmts: """
		mkdir \(Defs.painkiller)
		cd \(Defs.painkiller)
		\(Defs.cmdgo.modinit) \(Defs.painkiller)
		"""
}

Steps: basic_app: preguide.#Upload & {
	Target: "\(Defs.painkiller_dir)/\(Defs.painkiller_go)"
	Source: #"""
		package main

		import "fmt"

		type Pill int

		const (
			Placebo Pill = iota
			Ibuprofen
		)

		func main() {
			fmt.Printf("For headaches, take %v\n", Ibuprofen)
		}

		"""#
}

Steps: painkiller_run_basic: preguide.#Command & {
	Stmts: """
		\(Defs.cmdgo.run) .
		"""
}

Steps: manual_string: preguide.#Upload & {
	Target:   "\(Defs.painkiller_dir)/\(Defs.painkiller_go)"
	Renderer: preguide.#RenderDiff & {Pre: Steps.basic_app.Source}
	Source: #"""
		package main

		import "fmt"

		type Pill int

		func (p Pill) String() string {
			switch p {
			case Placebo:
				return "Placebo"
			case Ibuprofen:
				return "Ibuprofen"
			default:
				panic(fmt.Errorf("unknown Pill value %v", p))
			}
		}

		const (
			Placebo Pill = iota
			Ibuprofen
		)

		func main() {
			fmt.Printf("For headaches, take %v\n", Ibuprofen)
		}

		"""#
}

Steps: painkiller_run_manual_string: preguide.#Command & {
	Stmts: """
		\(Defs.cmdgo.run) .
		"""
}

Steps: painkiller_remove_hand_written_string: preguide.#Upload & {
	Target:   "\(Defs.painkiller_dir)/\(Defs.painkiller_go)"
	Renderer: preguide.#RenderDiff & {Pre: Steps.manual_string.Source}
	Source: #"""
		package main

		import "fmt"

		type Pill int

		const (
			Placebo Pill = iota
			Ibuprofen
		)

		func main() {
			fmt.Printf("For headaches, take %v\n", Ibuprofen)
		}

		"""#
}

Steps: tools_go_initial: preguide.#Upload & {
	Target: "\(Defs.painkiller_dir)/\(Defs.tools_go)"
	Source: #"""
		// +build \#(Defs.tools_constraint)

		package \#(Defs.tools_constraint)

		import (
			_ "\#(Defs.stringer_pkg)"
		)

		"""#
}

Steps: stringer_go_get: preguide.#Command & {
	Stmts: """
		\(Defs.cmdgo.get) \(Defs.stringer_pkg)@\(_#golangToolsLatest)
		"""
}

Steps: painkiller_cat_go_mod: preguide.#Command & {
	Stmts: """
		cat go.mod
		"""
}

Steps: painkiller_go_mod_tidy: preguide.#Command & {
	Stmts: """
		\(Defs.cmdgo.modtidy)
		"""
}

Steps: stringer_help: preguide.#Command & {
	Stmts: """
		\(Defs.cmdgo.run) \(Defs.stringer_pkg) -help
		"""
}

Steps: stringer_run_by_hand: preguide.#Command & {
	Stmts: """
		\(Defs.cmdgo.run) \(Defs.stringer_pkg) \(Defs.stringer_type_flag) Pill
		"""
}

Steps: stringer_ls_output: preguide.#Command & {
	Stmts: """
		ls
		"""
}

Steps: stringer_cat_generated: preguide.#Command & {
	Stmts: """
		cat pill_string.go
		"""
}

Steps: painkiller_check_stringer: preguide.#Command & {
	Stmts: """
		\(Defs.cmdgo.run) .
		"""
}

Steps: painkiller_add_gogenerate_directive: preguide.#Upload & {
	Target:   "\(Defs.painkiller_dir)/\(Defs.painkiller_go)"
	Renderer: preguide.#RenderDiff & {Pre: Steps.painkiller_remove_hand_written_string.Source}
	Source:   #"""
		package main

		import "fmt"

		//go:generate \#(Defs.cmdgo.run) \#(Defs.stringer_pkg) \#(Defs.stringer_type_flag)=Pill

		type Pill int

		const (
			Placebo Pill = iota
			Ibuprofen
		)

		func main() {
			fmt.Printf("For headaches, take %v\n", Ibuprofen)
		}

		"""#
}

Steps: painkiller_gogenerate: preguide.#Command & {
	Stmts: """
		\(Defs.cmdgo.generate) .
		"""
}

Steps: painkiller_add_fever_advice: preguide.#Upload & {
	Target:   "\(Defs.painkiller_dir)/\(Defs.painkiller_go)"
	Renderer: preguide.#RenderDiff & {Pre: Steps.painkiller_add_gogenerate_directive.Source}
	Source:   #"""
		package main

		import "fmt"

		//go:generate \#(Defs.cmdgo.run) \#(Defs.stringer_pkg) \#(Defs.stringer_type_flag)=Pill

		type Pill int

		const (
			Placebo Pill = iota
			Ibuprofen
			Paracetamol
		)

		func main() {
			fmt.Printf("For headaches, take %v\n", Ibuprofen)
			fmt.Printf("For a fever, take %v\n", Paracetamol)
		}

		"""#
}

Steps: painkiller_gogenerate_again: preguide.#Command & {
	Stmts: """
		\(Defs.cmdgo.generate) .
		"""
}

Steps: painkiller_check_fever_advice: preguide.#Command & {
	Stmts: """
		\(Defs.cmdgo.run) .
		"""
}
