package guide

import (
	"github.com/play-with-go/preguide"
)

Defs: {
	_#commonDefs
	staticcheck_version: "v0.0.1-2020.1.6"
	staticcheck_conf:    "staticcheck.conf"
	staticcheck_st1000:  "ST1000"
	staticcheck_sa4018:  "SA4018"
	pets:                "pets"
	pets_dir:            "/home/gopher/\(pets)"
	pets_go:             "\(pets).go"
	pets_mod:            "\(pets)"
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

Steps: staticcheck_install: preguide.#Command & {
	Source: """
		(cd $(mktemp -d); GO111MODULE=on go get honnef.co/go/tools/cmd/staticcheck@\(Defs.staticcheck_version))
		"""
}

Steps: go_env_gopath: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.env) GOPATH
		\(Defs.cmdgo.env) GOBIN
		"""
}

Steps: path_add_gopath_bin: preguide.#Command & {
	Source: """
		export PATH="$(go env GOPATH)/bin:$PATH"
		"""
}

Steps: staticcheck_check_on_path: preguide.#Command & {
	Source: """
		which staticcheck
		staticcheck -version
		"""
}

Steps: pets_init: preguide.#Command & {
	Source: """
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
	Source: """
		\(Defs.cmdgo.build)
		"""
}

Steps: pets_staticcheck_initial: preguide.#Command & {
	Source: """
		! staticcheck .
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
	Source: """
		staticcheck .
		"""
}

Steps: staticcheck_config_initial: preguide.#Upload & {
	Target: "\(Defs.pets_dir)/\(Defs.staticcheck_conf)"
	Source: #"""
		checks = ["inherit", "\#(Defs.staticcheck_st1000)"]

		"""#
}

Steps: pets_staticcheck_st1000_enabled: preguide.#Command & {
	Source: """
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
	Source: """
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
	Source: """
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
	Source: """
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
	Source: """
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
	Source: """
		staticcheck .
		"""
}
