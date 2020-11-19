package out

Terminals: [{
	Description: "The main terminal"
	Scenarios: {
		go115: {
			Image: "playwithgo/go1.15.5@sha256:2cc72c6bf72ce59de8aff52f7bbb0603926dbdd70473ec7f8b9f8310edf57ba4"
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
	pets_staticcheck_final: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "staticcheck ."
			Negated:          false
		}]
		Order:           22
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "pets_staticcheck_final"
	}
	pets_go_final: {
		Order: 21
		Source: """
			// Package pets contains useful functionality for pet owners
			package pets

			import (
			\t"fmt"
			)

			type Animal int

			const (
			\tDog Animal = iota
			\tSnake
			)

			type Pet struct {
			\tKind Animal
			\tName string
			}

			func (p Pet) Walk() error {
			\tswitch p.Kind {
			\tcase Dog:
			\t\tfmt.Printf("Will take %v for a walk around the block\\n", p.Name)
			\tdefault:
			\t\treturn fmt.Errorf("cannot take %v for a walk", p.Name)
			\t}
			\treturn nil
			}

			func (p Pet) Feed(food string) {
			\tfmt.Printf("Feeding %v some %v\\n", p.Name, food)
			}

			func (p Pet) String() string {
			\treturn p.Name
			}

			"""
		Renderer: {
			Pre: """
				// Package pets contains useful functionality for pet owners
				package pets

				import (
				\t"fmt"
				)

				//lint:file-ignore SA4018 trying out file-based linter directives

				type Animal int

				const (
				\tDog Animal = iota
				\tSnake
				)

				type Pet struct {
				\tKind Animal
				\tName string
				}

				func (p Pet) Walk() error {
				\tswitch p.Kind {
				\tcase Dog:
				\t\tfmt.Printf("Will take %v for a walk around the block\\n", p.Name)
				\tdefault:
				\t\treturn fmt.Errorf("cannot take %v for a walk", p.Name)
				\t}
				\treturn nil
				}

				func (p Pet) Feed(food string) {
				\tfood = food
				\tfmt.Printf("Feeding %v some %v\\n", p.Name, food)
				}

				func (p Pet) String() string {
				\treturn p.Name
				}

				"""
			RendererType: 3
		}
		Language: "go"
		Target:   "/home/gopher/pets/pets.go"
		Terminal: "term1"
		StepType: 2
		Name:     "pets_go_final"
	}
	pets_staticcheck_check_sa4018_still_ignored: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "staticcheck ."
			Negated:          false
		}]
		Order:           20
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "pets_staticcheck_check_sa4018_still_ignored"
	}
	pets_go_file_ignore_sa4018: {
		Order: 19
		Source: """
			// Package pets contains useful functionality for pet owners
			package pets

			import (
			\t"fmt"
			)

			//lint:file-ignore SA4018 trying out file-based linter directives

			type Animal int

			const (
			\tDog Animal = iota
			\tSnake
			)

			type Pet struct {
			\tKind Animal
			\tName string
			}

			func (p Pet) Walk() error {
			\tswitch p.Kind {
			\tcase Dog:
			\t\tfmt.Printf("Will take %v for a walk around the block\\n", p.Name)
			\tdefault:
			\t\treturn fmt.Errorf("cannot take %v for a walk", p.Name)
			\t}
			\treturn nil
			}

			func (p Pet) Feed(food string) {
			\tfood = food
			\tfmt.Printf("Feeding %v some %v\\n", p.Name, food)
			}

			func (p Pet) String() string {
			\treturn p.Name
			}

			"""
		Renderer: {
			Pre: """
				// Package pets contains useful functionality for pet owners
				package pets

				import (
				\t"fmt"
				)

				type Animal int

				const (
				\tDog Animal = iota
				\tSnake
				)

				type Pet struct {
				\tKind Animal
				\tName string
				}

				func (p Pet) Walk() error {
				\tswitch p.Kind {
				\tcase Dog:
				\t\tfmt.Printf("Will take %v for a walk around the block\\n", p.Name)
				\tdefault:
				\t\treturn fmt.Errorf("cannot take %v for a walk", p.Name)
				\t}
				\treturn nil
				}

				func (p Pet) Feed(food string) {
				\t//lint:ignore SA4018 trying out line-based linter directives
				\tfood = food
				\tfmt.Printf("Feeding %v some %v\\n", p.Name, food)
				}

				func (p Pet) String() string {
				\treturn p.Name
				}

				"""
			RendererType: 3
		}
		Language: "go"
		Target:   "/home/gopher/pets/pets.go"
		Terminal: "term1"
		StepType: 2
		Name:     "pets_go_file_ignore_sa4018"
	}
	pets_staticcheck_check_sa4018_ignored: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "staticcheck ."
			Negated:          false
		}]
		Order:           18
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "pets_staticcheck_check_sa4018_ignored"
	}
	pets_go_ignore_sa4018: {
		Order: 17
		Source: """
			// Package pets contains useful functionality for pet owners
			package pets

			import (
			\t"fmt"
			)

			type Animal int

			const (
			\tDog Animal = iota
			\tSnake
			)

			type Pet struct {
			\tKind Animal
			\tName string
			}

			func (p Pet) Walk() error {
			\tswitch p.Kind {
			\tcase Dog:
			\t\tfmt.Printf("Will take %v for a walk around the block\\n", p.Name)
			\tdefault:
			\t\treturn fmt.Errorf("cannot take %v for a walk", p.Name)
			\t}
			\treturn nil
			}

			func (p Pet) Feed(food string) {
			\t//lint:ignore SA4018 trying out line-based linter directives
			\tfood = food
			\tfmt.Printf("Feeding %v some %v\\n", p.Name, food)
			}

			func (p Pet) String() string {
			\treturn p.Name
			}

			"""
		Renderer: {
			Pre: """
				// Package pets contains useful functionality for pet owners
				package pets

				import (
				\t"fmt"
				)

				type Animal int

				const (
				\tDog Animal = iota
				\tSnake
				)

				type Pet struct {
				\tKind Animal
				\tName string
				}

				func (p Pet) Walk() error {
				\tswitch p.Kind {
				\tcase Dog:
				\t\tfmt.Printf("Will take %v for a walk around the block\\n", p.Name)
				\tdefault:
				\t\treturn fmt.Errorf("cannot take %v for a walk", p.Name)
				\t}
				\treturn nil
				}

				func (p Pet) Feed(food string) {
				\tfood = food
				\tfmt.Printf("Feeding %v some %v\\n", p.Name, food)
				}

				func (p Pet) String() string {
				\treturn p.Name
				}

				"""
			RendererType: 3
		}
		Language: "go"
		Target:   "/home/gopher/pets/pets.go"
		Terminal: "term1"
		StepType: 2
		Name:     "pets_go_ignore_sa4018"
	}
	pets_staticcheck_check_feed: {
		Stmts: [{
			ComparisonOutput: """
				pets.go:31:2: self-assignment of food to food (SA4018)

				"""
			Output: """
				pets.go:31:2: self-assignment of food to food (SA4018)

				"""
			ExitCode: 1
			CmdStr:   "staticcheck ."
			Negated:  true
		}]
		Order:           16
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "pets_staticcheck_check_feed"
	}
	pets_go_feed: {
		Order: 15
		Source: """
			// Package pets contains useful functionality for pet owners
			package pets

			import (
			\t"fmt"
			)

			type Animal int

			const (
			\tDog Animal = iota
			\tSnake
			)

			type Pet struct {
			\tKind Animal
			\tName string
			}

			func (p Pet) Walk() error {
			\tswitch p.Kind {
			\tcase Dog:
			\t\tfmt.Printf("Will take %v for a walk around the block\\n", p.Name)
			\tdefault:
			\t\treturn fmt.Errorf("cannot take %v for a walk", p.Name)
			\t}
			\treturn nil
			}

			func (p Pet) Feed(food string) {
			\tfood = food
			\tfmt.Printf("Feeding %v some %v\\n", p.Name, food)
			}

			func (p Pet) String() string {
			\treturn p.Name
			}

			"""
		Renderer: {
			Pre: """
				// Package pets contains useful functionality for pet owners
				package pets

				import (
				\t"fmt"
				)

				type Animal int

				const (
				\tDog Animal = iota
				\tSnake
				)

				type Pet struct {
				\tKind Animal
				\tName string
				}

				func (p Pet) Walk() error {
				\tswitch p.Kind {
				\tcase Dog:
				\t\tfmt.Printf("Will take %v for a walk around the block\\n", p.Name)
				\tdefault:
				\t\treturn fmt.Errorf("cannot take %v for a walk", p.Name)
				\t}
				\treturn nil
				}

				func (p Pet) String() string {
				\treturn p.Name
				}

				"""
			RendererType: 3
		}
		Language: "go"
		Target:   "/home/gopher/pets/pets.go"
		Terminal: "term1"
		StepType: 2
		Name:     "pets_go_feed"
	}
	pets_staticcheck_st1000_fixed: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "staticcheck ."
			Negated:          false
		}]
		Order:           14
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "pets_staticcheck_st1000_fixed"
	}
	pets_go_with_package_comment: {
		Order: 13
		Source: """
			// Package pets contains useful functionality for pet owners
			package pets

			import (
			\t"fmt"
			)

			type Animal int

			const (
			\tDog Animal = iota
			\tSnake
			)

			type Pet struct {
			\tKind Animal
			\tName string
			}

			func (p Pet) Walk() error {
			\tswitch p.Kind {
			\tcase Dog:
			\t\tfmt.Printf("Will take %v for a walk around the block\\n", p.Name)
			\tdefault:
			\t\treturn fmt.Errorf("cannot take %v for a walk", p.Name)
			\t}
			\treturn nil
			}

			func (p Pet) String() string {
			\treturn p.Name
			}

			"""
		Renderer: {
			Pre: """
				package pets

				import (
				\t"fmt"
				)

				type Animal int

				const (
				\tDog Animal = iota
				\tSnake
				)

				type Pet struct {
				\tKind Animal
				\tName string
				}

				func (p Pet) Walk() error {
				\tswitch p.Kind {
				\tcase Dog:
				\t\tfmt.Printf("Will take %v for a walk around the block\\n", p.Name)
				\tdefault:
				\t\treturn fmt.Errorf("cannot take %v for a walk", p.Name)
				\t}
				\treturn nil
				}

				func (p Pet) String() string {
				\treturn p.Name
				}

				"""
			RendererType: 3
		}
		Language: "go"
		Target:   "/home/gopher/pets/pets.go"
		Terminal: "term1"
		StepType: 2
		Name:     "pets_go_with_package_comment"
	}
	pets_staticcheck_st1000_enabled: {
		Stmts: [{
			ComparisonOutput: """
				pets.go:1:1: at least one file in a package should have a package comment (ST1000)

				"""
			Output: """
				pets.go:1:1: at least one file in a package should have a package comment (ST1000)

				"""
			ExitCode: 1
			CmdStr:   "staticcheck ."
			Negated:  true
		}]
		Order:           12
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "pets_staticcheck_st1000_enabled"
	}
	staticcheck_config_initial: {
		Order: 11
		Source: """
			checks = ["inherit", "ST1000"]

			"""
		Renderer: {
			RendererType: 1
		}
		Language: "conf"
		Target:   "/home/gopher/pets/staticcheck.conf"
		Terminal: "term1"
		StepType: 2
		Name:     "staticcheck_config_initial"
	}
	pets_staticcheck_fixed: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "staticcheck ."
			Negated:          false
		}]
		Order:           10
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "pets_staticcheck_fixed"
	}
	pets_go_fixed: {
		Order: 9
		Source: """
			package pets

			import (
			\t"fmt"
			)

			type Animal int

			const (
			\tDog Animal = iota
			\tSnake
			)

			type Pet struct {
			\tKind Animal
			\tName string
			}

			func (p Pet) Walk() error {
			\tswitch p.Kind {
			\tcase Dog:
			\t\tfmt.Printf("Will take %v for a walk around the block\\n", p.Name)
			\tdefault:
			\t\treturn fmt.Errorf("cannot take %v for a walk", p.Name)
			\t}
			\treturn nil
			}

			func (p Pet) String() string {
			\treturn p.Name
			}

			"""
		Renderer: {
			Pre: """
				package pets

				import (
				\t"errors"
				\t"fmt"
				)

				type Animal int

				const (
				\tDog Animal = iota
				\tSnake
				)

				type Pet struct {
				\tKind Animal
				\tName string
				}

				func (p Pet) Walk() error {
				\tswitch p.Kind {
				\tcase Dog:
				\t\tfmt.Printf("Will take %v for a walk around the block\\n")
				\tdefault:
				\t\treturn errors.New(fmt.Sprintf("Cannot take %v for a walk", p.Name))
				\t}
				\treturn nil
				}

				func (self Pet) String() string {
				\treturn fmt.Sprintf("%s", self.Name)
				}

				"""
			RendererType: 3
		}
		Language: "go"
		Target:   "/home/gopher/pets/pets.go"
		Terminal: "term1"
		StepType: 2
		Name:     "pets_go_fixed"
	}
	staticcheck_explain: {
		Stmts: [{
			ComparisonOutput: """
				Invalid Printf call

				Available since
				    2019.2


				"""
			Output: """
				Invalid Printf call

				Available since
				    2019.2


				"""
			ExitCode: 0
			CmdStr:   "staticcheck -explain SA5009"
			Negated:  false
		}]
		Order:           8
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "staticcheck_explain"
	}
	pets_staticcheck_initial: {
		Stmts: [{
			ComparisonOutput: """
				pets.go:23:14: Printf format %v reads arg #1, but call has only 0 args (SA5009)
				pets.go:25:10: should use fmt.Errorf(...) instead of errors.New(fmt.Sprintf(...)) (S1028)
				pets.go:30:7: receiver name should be a reflection of its identity; don't use generic names such as "this" or "self" (ST1006)
				pets.go:31:9: the argument is already a string, there's no need to use fmt.Sprintf (S1025)

				"""
			Output: """
				pets.go:23:14: Printf format %v reads arg #1, but call has only 0 args (SA5009)
				pets.go:25:10: should use fmt.Errorf(...) instead of errors.New(fmt.Sprintf(...)) (S1028)
				pets.go:30:7: receiver name should be a reflection of its identity; don't use generic names such as "this" or "self" (ST1006)
				pets.go:31:9: the argument is already a string, there's no need to use fmt.Sprintf (S1025)

				"""
			ExitCode: 1
			CmdStr:   "staticcheck ."
			Negated:  true
		}]
		Order:           7
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "pets_staticcheck_initial"
	}
	pets_build_initial: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "go build"
			Negated:          false
		}]
		Order:           6
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "pets_build_initial"
	}
	pets_go_initial: {
		Order: 5
		Source: """
			package pets

			import (
			\t"errors"
			\t"fmt"
			)

			type Animal int

			const (
			\tDog Animal = iota
			\tSnake
			)

			type Pet struct {
			\tKind Animal
			\tName string
			}

			func (p Pet) Walk() error {
			\tswitch p.Kind {
			\tcase Dog:
			\t\tfmt.Printf("Will take %v for a walk around the block\\n")
			\tdefault:
			\t\treturn errors.New(fmt.Sprintf("Cannot take %v for a walk", p.Name))
			\t}
			\treturn nil
			}

			func (self Pet) String() string {
			\treturn fmt.Sprintf("%s", self.Name)
			}

			"""
		Renderer: {
			RendererType: 1
		}
		Language: "go"
		Target:   "/home/gopher/pets/pets.go"
		Terminal: "term1"
		StepType: 2
		Name:     "pets_go_initial"
	}
	pets_init: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "mkdir /home/gopher/pets"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/pets"
			Negated:          false
		}, {
			ComparisonOutput: """
				go: creating new go.mod: module pets

				"""
			Output: """
				go: creating new go.mod: module pets

				"""
			ExitCode: 0
			CmdStr:   "go mod init pets"
			Negated:  false
		}]
		Order:           4
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "pets_init"
	}
	staticcheck_check_on_path: {
		Stmts: [{
			ComparisonOutput: """
				/home/gopher/go/bin/staticcheck

				"""
			Output: """
				/home/gopher/go/bin/staticcheck

				"""
			ExitCode: 0
			CmdStr:   "which staticcheck"
			Negated:  false
		}]
		Order:           2
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "staticcheck_check_on_path"
	}
	staticcheck_install: {
		Stmts: [{
			ComparisonOutput: """

				go: downloading github.com/BurntSushi/toml v0.3.1
				go: downloading golang.org/x/tools v0.0.0-20200410194907-79a7a3126eef
				go: downloading golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543
				go: downloading honnef.co/go/tools v0.0.1-2020.1.6
				go: found honnef.co/go/tools/cmd/staticcheck in honnef.co/go/tools v0.0.1-2020.1.6
				"""
			Output: """
				go: downloading honnef.co/go/tools v0.0.1-2020.1.6
				go: found honnef.co/go/tools/cmd/staticcheck in honnef.co/go/tools v0.0.1-2020.1.6
				go: downloading golang.org/x/tools v0.0.0-20200410194907-79a7a3126eef
				go: downloading github.com/BurntSushi/toml v0.3.1
				go: downloading golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543

				"""
			ExitCode: 0
			CmdStr:   "(cd $(mktemp -d); GO111MODULE=on go get honnef.co/go/tools/cmd/staticcheck@v0.0.1-2020.1.6)"
			Negated:  false
		}]
		Order:           1
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "staticcheck_install"
	}
	staticcheck_version: {
		Stmts: [{
			ComparisonOutput: """
				staticcheck 2020.1.6

				"""
			Output: """
				staticcheck 2020.1.6

				"""
			ExitCode: 0
			CmdStr:   "staticcheck -version"
			Negated:  false
		}]
		Order:           3
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "staticcheck_version"
	}
	goversion: {
		Stmts: [{
			ComparisonOutput: """
				go version go1.15.5 linux/amd64

				"""
			Output: """
				go version go1.15.5 linux/amd64

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
}
Hash: "0d02673b9b2c8f3d4fcd94bac0d1ffe8481f51d28b96e957df86fe8bc27c5114"
Delims: ["{{{", "}}}"]
