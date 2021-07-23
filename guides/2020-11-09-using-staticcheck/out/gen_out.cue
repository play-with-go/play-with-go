package out

Terminals: [{
	Name:        "term1"
	Description: "The main terminal"
	Scenarios: {
		go115: {
			Image: "playwithgo/go1.15.8@sha256:7640da09d1555c4dddbba7f1b96051af2816e6542005176b749f38865ee0454c"
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
				go version go1.15.8 linux/amd64

				"""
			ComparisonOutput: """
				go version go1.15.8 linux/amd64

				"""
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
			CmdStr:   "(cd $(mktemp -d); GO111MODULE=on go get honnef.co/go/tools/cmd/staticcheck@v0.0.1-2020.1.6)"
			ExitCode: 0
			Output: """
				go: downloading honnef.co/go/tools v0.0.1-2020.1.6
				go: found honnef.co/go/tools/cmd/staticcheck in honnef.co/go/tools v0.0.1-2020.1.6
				go: downloading golang.org/x/tools v0.0.0-20200410194907-79a7a3126eef
				go: downloading golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543
				go: downloading github.com/BurntSushi/toml v0.3.1

				"""
			ComparisonOutput: """

				go: downloading github.com/BurntSushi/toml v0.3.1
				go: downloading golang.org/x/tools v0.0.0-20200410194907-79a7a3126eef
				go: downloading golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543
				go: downloading honnef.co/go/tools v0.0.1-2020.1.6
				go: found honnef.co/go/tools/cmd/staticcheck in honnef.co/go/tools v0.0.1-2020.1.6
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
				staticcheck 2020.1.6

				"""
			ComparisonOutput: """
				staticcheck 2020.1.6

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


				"""
			ComparisonOutput: """
				Invalid Printf call

				Available since
				    2019.2


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
Hash: "3fe2d351775751fe4a3f807d62ae62aacd124f6e1af2be7e3348f3e9689ff771"
Delims: ["{{{", "}}}"]
