package out

Terminals: [{
	Name:        "term1"
	Description: "The main terminal"
	Scenarios: {
		go119: {
			Image: "playwithgo/go1.19.1:5966cd5f1b8ef645576f95bcb19fff827d6ca560"
		}
	}
}]
Scenarios: [{
	Name:        "go119"
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
			Negated:          false
			CmdStr:           "go version"
			ExitCode:         0
			Output:           "go version go1.19.1 linux/amd64"
			ComparisonOutput: "go version go1.19.1 linux/amd64"
		}]
	}
	staticcheck_install: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "staticcheck_install"
		Order:           1
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go install honnef.co/go/tools/cmd/staticcheck@v0.3.3"
			ExitCode: 0
			Output: """
				go: downloading honnef.co/go/tools v0.3.3
				go: downloading golang.org/x/tools v0.1.11-0.20220513221640-090b14e8501f
				go: downloading golang.org/x/exp/typeparams v0.0.0-20220218215828-6cf2b201936e
				go: downloading golang.org/x/sys v0.0.0-20211019181941-9d821ace8654
				go: downloading github.com/BurntSushi/toml v0.4.1
				go: downloading golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4

				"""
			ComparisonOutput: """
				go: downloading honnef.co/go/tools v0.3.3
				go: downloading golang.org/x/tools v0.1.11-0.20220513221640-090b14e8501f
				go: downloading golang.org/x/exp/typeparams v0.0.0-20220218215828-6cf2b201936e
				go: downloading golang.org/x/sys v0.0.0-20211019181941-9d821ace8654
				go: downloading github.com/BurntSushi/toml v0.4.1
				go: downloading golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4

				"""
		}]
	}
	staticcheck_check_on_path: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "staticcheck_check_on_path"
		Order:           2
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "which staticcheck"
			ExitCode: 0
			Output: """
				/home/gopher/go/bin/staticcheck

				"""
			ComparisonOutput: """
				/home/gopher/go/bin/staticcheck

				"""
		}]
	}
	staticcheck_version: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "staticcheck_version"
		Order:           3
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "staticcheck -version"
			ExitCode: 0
			Output: """
				staticcheck 2022.1.3 (v0.3.3)

				"""
			ComparisonOutput: """
				staticcheck 2022.1.3 (v0.3.3)

				"""
		}]
	}
	pets_init: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "pets_init"
		Order:           4
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "mkdir /home/gopher/pets"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cd /home/gopher/pets"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "go mod init pets"
			ExitCode: 0
			Output: """
				go: creating new go.mod: module pets

				"""
			ComparisonOutput: """
				go: creating new go.mod: module pets

				"""
		}]
	}
	pets_go_initial: {
		StepType: 2
		Name:     "pets_go_initial"
		Order:    5
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
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
		Target: "/home/gopher/pets/pets.go"
	}
	pets_build_initial: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "pets_build_initial"
		Order:           6
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "go build"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	pets_staticcheck_initial: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "pets_staticcheck_initial"
		Order:           7
		Terminal:        "term1"
		Stmts: [{
			Negated:  true
			CmdStr:   "staticcheck ."
			ExitCode: 1
			Output: """
				pets.go:23:14: Printf format %v reads arg #1, but call has only 0 args (SA5009)
				pets.go:25:10: should use fmt.Errorf(...) instead of errors.New(fmt.Sprintf(...)) (S1028)
				pets.go:30:7: receiver name should be a reflection of its identity; don't use generic names such as "this" or "self" (ST1006)
				pets.go:31:9: the argument is already a string, there's no need to use fmt.Sprintf (S1025)

				"""
			ComparisonOutput: """
				pets.go:23:14: Printf format %v reads arg #1, but call has only 0 args (SA5009)
				pets.go:25:10: should use fmt.Errorf(...) instead of errors.New(fmt.Sprintf(...)) (S1028)
				pets.go:30:7: receiver name should be a reflection of its identity; don't use generic names such as "this" or "self" (ST1006)
				pets.go:31:9: the argument is already a string, there's no need to use fmt.Sprintf (S1025)

				"""
		}]
	}
	staticcheck_explain: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "staticcheck_explain"
		Order:           8
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "staticcheck -explain SA5009"
			ExitCode: 0
			Output: """
				Invalid Printf call

				Available since
				    2019.2

				Online documentation
				    https://staticcheck.io/docs/checks#SA5009

				"""
			ComparisonOutput: """
				Invalid Printf call

				Available since
				    2019.2

				Online documentation
				    https://staticcheck.io/docs/checks#SA5009

				"""
		}]
	}
	pets_go_fixed: {
		StepType: 2
		Name:     "pets_go_fixed"
		Order:    9
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 3
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
		}
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
		Target: "/home/gopher/pets/pets.go"
	}
	pets_staticcheck_fixed: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "pets_staticcheck_fixed"
		Order:           10
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "staticcheck ."
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	staticcheck_config_initial: {
		StepType: 2
		Name:     "staticcheck_config_initial"
		Order:    11
		Terminal: "term1"
		Language: "toml"
		Renderer: {
			RendererType: 1
		}
		Source: """
			checks = ["inherit", "ST1000"]

			"""
		Target: "/home/gopher/pets/staticcheck.conf"
	}
	pets_staticcheck_st1000_enabled: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "pets_staticcheck_st1000_enabled"
		Order:           12
		Terminal:        "term1"
		Stmts: [{
			Negated:  true
			CmdStr:   "staticcheck ."
			ExitCode: 1
			Output: """
				pets.go:1:1: at least one file in a package should have a package comment (ST1000)

				"""
			ComparisonOutput: """
				pets.go:1:1: at least one file in a package should have a package comment (ST1000)

				"""
		}]
	}
	pets_go_with_package_comment: {
		StepType: 2
		Name:     "pets_go_with_package_comment"
		Order:    13
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 3
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
		}
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
		Target: "/home/gopher/pets/pets.go"
	}
	pets_staticcheck_st1000_fixed: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "pets_staticcheck_st1000_fixed"
		Order:           14
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "staticcheck ."
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	pets_go_feed: {
		StepType: 2
		Name:     "pets_go_feed"
		Order:    15
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 3
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
		}
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
		Target: "/home/gopher/pets/pets.go"
	}
	pets_staticcheck_check_feed: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "pets_staticcheck_check_feed"
		Order:           16
		Terminal:        "term1"
		Stmts: [{
			Negated:  true
			CmdStr:   "staticcheck ."
			ExitCode: 1
			Output: """
				pets.go:31:2: self-assignment of food to food (SA4018)

				"""
			ComparisonOutput: """
				pets.go:31:2: self-assignment of food to food (SA4018)

				"""
		}]
	}
	pets_go_ignore_sa4018: {
		StepType: 2
		Name:     "pets_go_ignore_sa4018"
		Order:    17
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 3
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
		}
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
		Target: "/home/gopher/pets/pets.go"
	}
	pets_staticcheck_check_sa4018_ignored: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "pets_staticcheck_check_sa4018_ignored"
		Order:           18
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "staticcheck ."
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	pets_go_file_ignore_sa4018: {
		StepType: 2
		Name:     "pets_go_file_ignore_sa4018"
		Order:    19
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 3
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
		}
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
		Target: "/home/gopher/pets/pets.go"
	}
	pets_staticcheck_check_sa4018_still_ignored: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "pets_staticcheck_check_sa4018_still_ignored"
		Order:           20
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "staticcheck ."
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	pets_go_final: {
		StepType: 2
		Name:     "pets_go_final"
		Order:    21
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 3
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
		}
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
		Target: "/home/gopher/pets/pets.go"
	}
	pets_staticcheck_final: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "pets_staticcheck_final"
		Order:           22
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "staticcheck ."
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
}
Hash: "29d51f4a617087a8662817a9ec8eae7670ad5825297397b2df912324ff2c1071"
Delims: ["{{{", "}}}"]
