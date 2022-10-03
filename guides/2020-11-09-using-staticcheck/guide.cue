package guide

import (
	"github.com/play-with-go/preguide"
)

Defs: {
	_#commonDefs
	staticcheck_version:      "v0.3.3"
	staticcheck_conf:         "staticcheck.conf"
	staticcheck_st1000:       "ST1000"
	staticcheck_sa4018:       "SA4018"
	staticcheck_sa5009:       "SA5009"
	staticcheck_explain_flag: "-explain"
	pets:                     "pets"
	pets_dir:                 "/home/gopher/\(pets)"
	pets_go:                  "\(pets).go"
	pets_mod:                 "\(pets)"
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

Steps: staticcheck_install: preguide.#Command & {
	Stmts: """
		go install honnef.co/go/tools/cmd/staticcheck@\(Defs.staticcheck_version)
		"""
}

Steps: staticcheck_check_on_path: preguide.#Command & {
	Stmts: """
		which staticcheck
		"""
}

Steps: staticcheck_version: preguide.#Command & {
	Stmts: """
		staticcheck -version
		"""
}

Steps: pets_init: preguide.#Command & {
	Stmts: """
		mkdir \(Defs.pets_dir)
		cd \(Defs.pets_dir)
		\(Defs.cmdgo.modinit) \(Defs.pets_mod)
		"""
}

Steps: pets_go_initial: preguide.#Upload & {
	Target: "\(Defs.pets_dir)/\(Defs.pets_go)"
	// Renderer: preguide.#RenderDiff & {Pre: Steps.create_greetingsgo.Source}
	Source: #"""
		package \#(Defs.pets)

		import (
			"errors"
			"fmt"
		)

		type Animal int

		const (
			Dog Animal = iota
			Snake
		)

		type Pet struct {
			Kind Animal
			Name string
		}

		func (p Pet) Walk() error {
			switch p.Kind {
			case Dog:
				fmt.Printf("Will take %v for a walk around the block\n")
			default:
				return errors.New(fmt.Sprintf("Cannot take %v for a walk", p.Name))
			}
			return nil
		}

		func (self Pet) String() string {
			return fmt.Sprintf("%s", self.Name)
		}

		"""#
}

Steps: pets_build_initial: preguide.#Command & {
	Stmts: """
		\(Defs.cmdgo.build)
		"""
}

Steps: pets_staticcheck_initial: preguide.#Command & {
	Stmts: """
		! staticcheck .
		"""
}

Steps: staticcheck_explain: preguide.#Command & {
	Stmts: """
		staticcheck \(Defs.staticcheck_explain_flag) \(Defs.staticcheck_sa5009)
		"""
}

Steps: pets_go_fixed: preguide.#Upload & {
	Target:   "\(Defs.pets_dir)/\(Defs.pets_go)"
	Renderer: preguide.#RenderDiff & {Pre: Steps.pets_go_initial.Source}
	Source:   #"""
		package \#(Defs.pets)

		import (
			"fmt"
		)

		type Animal int

		const (
			Dog Animal = iota
			Snake
		)

		type Pet struct {
			Kind Animal
			Name string
		}

		func (p Pet) Walk() error {
			switch p.Kind {
			case Dog:
				fmt.Printf("Will take %v for a walk around the block\n", p.Name)
			default:
				return fmt.Errorf("cannot take %v for a walk", p.Name)
			}
			return nil
		}

		func (p Pet) String() string {
			return p.Name
		}

		"""#
}

Steps: pets_staticcheck_fixed: preguide.#Command & {
	Stmts: """
		staticcheck .
		"""
}

Steps: staticcheck_config_initial: preguide.#Upload & {
	Target:   "\(Defs.pets_dir)/\(Defs.staticcheck_conf)"
	Language: "toml"
	Source:   #"""
		checks = ["inherit", "\#(Defs.staticcheck_st1000)"]

		"""#
}

Steps: pets_staticcheck_st1000_enabled: preguide.#Command & {
	Stmts: """
		! staticcheck .
		"""
}

Steps: pets_go_with_package_comment: preguide.#Upload & {
	Target:   "\(Defs.pets_dir)/\(Defs.pets_go)"
	Renderer: preguide.#RenderDiff & {Pre: Steps.pets_go_fixed.Source}
	Source:   #"""
		// Package \#(Defs.pets) contains useful functionality for pet owners
		package \#(Defs.pets)

		import (
			"fmt"
		)

		type Animal int

		const (
			Dog Animal = iota
			Snake
		)

		type Pet struct {
			Kind Animal
			Name string
		}

		func (p Pet) Walk() error {
			switch p.Kind {
			case Dog:
				fmt.Printf("Will take %v for a walk around the block\n", p.Name)
			default:
				return fmt.Errorf("cannot take %v for a walk", p.Name)
			}
			return nil
		}

		func (p Pet) String() string {
			return p.Name
		}

		"""#
}

Steps: pets_staticcheck_st1000_fixed: preguide.#Command & {
	Stmts: """
		staticcheck .
		"""
}

Steps: pets_go_feed: preguide.#Upload & {
	Target:   "\(Defs.pets_dir)/\(Defs.pets_go)"
	Renderer: preguide.#RenderDiff & {Pre: Steps.pets_go_with_package_comment.Source}
	Source:   #"""
		// Package \#(Defs.pets) contains useful functionality for pet owners
		package \#(Defs.pets)

		import (
			"fmt"
		)

		type Animal int

		const (
			Dog Animal = iota
			Snake
		)

		type Pet struct {
			Kind Animal
			Name string
		}

		func (p Pet) Walk() error {
			switch p.Kind {
			case Dog:
				fmt.Printf("Will take %v for a walk around the block\n", p.Name)
			default:
				return fmt.Errorf("cannot take %v for a walk", p.Name)
			}
			return nil
		}

		func (p Pet) Feed(food string) {
			food = food
			fmt.Printf("Feeding %v some %v\n", p.Name, food)
		}

		func (p Pet) String() string {
			return p.Name
		}

		"""#
}

Steps: pets_staticcheck_check_feed: preguide.#Command & {
	Stmts: """
		! staticcheck .
		"""
}

Steps: pets_go_ignore_sa4018: preguide.#Upload & {
	Target:   "\(Defs.pets_dir)/\(Defs.pets_go)"
	Renderer: preguide.#RenderDiff & {Pre: Steps.pets_go_feed.Source}
	Source:   #"""
		// Package \#(Defs.pets) contains useful functionality for pet owners
		package \#(Defs.pets)

		import (
			"fmt"
		)

		type Animal int

		const (
			Dog Animal = iota
			Snake
		)

		type Pet struct {
			Kind Animal
			Name string
		}

		func (p Pet) Walk() error {
			switch p.Kind {
			case Dog:
				fmt.Printf("Will take %v for a walk around the block\n", p.Name)
			default:
				return fmt.Errorf("cannot take %v for a walk", p.Name)
			}
			return nil
		}

		func (p Pet) Feed(food string) {
			//lint:ignore SA4018 trying out line-based linter directives
			food = food
			fmt.Printf("Feeding %v some %v\n", p.Name, food)
		}

		func (p Pet) String() string {
			return p.Name
		}

		"""#
}

Steps: pets_staticcheck_check_sa4018_ignored: preguide.#Command & {
	Stmts: """
		staticcheck .
		"""
}

Steps: pets_go_file_ignore_sa4018: preguide.#Upload & {
	Target:   "\(Defs.pets_dir)/\(Defs.pets_go)"
	Renderer: preguide.#RenderDiff & {Pre: Steps.pets_go_ignore_sa4018.Source}
	Source:   #"""
		// Package \#(Defs.pets) contains useful functionality for pet owners
		package \#(Defs.pets)

		import (
			"fmt"
		)

		//lint:file-ignore SA4018 trying out file-based linter directives

		type Animal int

		const (
			Dog Animal = iota
			Snake
		)

		type Pet struct {
			Kind Animal
			Name string
		}

		func (p Pet) Walk() error {
			switch p.Kind {
			case Dog:
				fmt.Printf("Will take %v for a walk around the block\n", p.Name)
			default:
				return fmt.Errorf("cannot take %v for a walk", p.Name)
			}
			return nil
		}

		func (p Pet) Feed(food string) {
			food = food
			fmt.Printf("Feeding %v some %v\n", p.Name, food)
		}

		func (p Pet) String() string {
			return p.Name
		}

		"""#
}

Steps: pets_staticcheck_check_sa4018_still_ignored: preguide.#Command & {
	Stmts: """
		staticcheck .
		"""
}

Steps: pets_go_final: preguide.#Upload & {
	Target:   "\(Defs.pets_dir)/\(Defs.pets_go)"
	Renderer: preguide.#RenderDiff & {Pre: Steps.pets_go_file_ignore_sa4018.Source}
	Source:   #"""
		// Package \#(Defs.pets) contains useful functionality for pet owners
		package \#(Defs.pets)

		import (
			"fmt"
		)

		type Animal int

		const (
			Dog Animal = iota
			Snake
		)

		type Pet struct {
			Kind Animal
			Name string
		}

		func (p Pet) Walk() error {
			switch p.Kind {
			case Dog:
				fmt.Printf("Will take %v for a walk around the block\n", p.Name)
			default:
				return fmt.Errorf("cannot take %v for a walk", p.Name)
			}
			return nil
		}

		func (p Pet) Feed(food string) {
			fmt.Printf("Feeding %v some %v\n", p.Name, food)
		}

		func (p Pet) String() string {
			return p.Name
		}

		"""#
}

Steps: pets_staticcheck_final: preguide.#Command & {
	Stmts: """
		staticcheck .
		"""
}
