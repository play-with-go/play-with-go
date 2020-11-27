package out

Presteps: [{
	Package: "github.com/play-with-go/gitea"
	Path:    "/newuser"
	Args: {
		Repos: [{
			Pattern: "painkiller"
			Private: false
			Var:     "PAINKILLER"
		}]
	}
	Version: """
		{
		  "Path": "github.com/play-with-go/gitea/cmd/gitea",
		  "Main": {
		    "Path": "github.com/play-with-go/gitea",
		    "Version": "v0.0.0-20201117212359-e8c942fd23b1",
		    "Sum": "h1:GF1ytqY5ImU/VwbxBRfry/sOIsXpZWwxUM50WNRySeo=",
		    "Replace": null
		  },
		  "Deps": [
		    {
		      "Path": "code.gitea.io/sdk/gitea",
		      "Version": "v0.13.1",
		      "Sum": "h1:Y7bpH2iO6Q0KhhMJfjP/LZ0AmiYITeRQlCD8b0oYqhk=",
		      "Replace": null
		    },
		    {
		      "Path": "cuelang.org/go",
		      "Version": "v0.3.0-alpha5.0.20201125190328-110d0bffb886",
		      "Sum": "h1:AH0SmnFFudNmu7ZFcKV8aNOAiPC/3nC5M9zfh50pLzk=",
		      "Replace": null
		    },
		    {
		      "Path": "github.com/cockroachdb/apd/v2",
		      "Version": "v2.0.1",
		      "Sum": "h1:y1Rh3tEU89D+7Tgbw+lp52T6p/GJLpDmNvr10UWqLTE=",
		      "Replace": null
		    },
		    {
		      "Path": "github.com/emicklei/proto",
		      "Version": "v1.6.15",
		      "Sum": "h1:XbpwxmuOPrdES97FrSfpyy67SSCV/wBIKXqgJzh6hNw=",
		      "Replace": null
		    },
		    {
		      "Path": "github.com/hashicorp/go-version",
		      "Version": "v1.2.0",
		      "Sum": "h1:3vNe/fWF5CBgRIguda1meWhsZHy3m8gCJ5wx+dIzX/E=",
		      "Replace": null
		    },
		    {
		      "Path": "github.com/mpvl/unique",
		      "Version": "v0.0.0-20150818121801-cbe035fff7de",
		      "Sum": "h1:D5x39vF5KCwKQaw+OC9ZPiLVHXz3UFw2+psEX+gYcto=",
		      "Replace": null
		    },
		    {
		      "Path": "github.com/pkg/errors",
		      "Version": "v0.8.1",
		      "Sum": "h1:iURUrRGxPUNPdy5/HRSm+Yj6okJ6UtLINN0Q9M4+h3I=",
		      "Replace": null
		    },
		    {
		      "Path": "github.com/play-with-go/preguide",
		      "Version": "v0.0.2-0.20201127064237-60c1cbc298ce",
		      "Sum": "h1:G+SARY3jyPp4RLbXTusrALhXMDY4JaslhkXoDx0MmdI=",
		      "Replace": null
		    },
		    {
		      "Path": "golang.org/x/crypto",
		      "Version": "v0.0.0-20191011191535-87dc89f01550",
		      "Sum": "h1:ObdrDkeb4kJdCP557AjRjq69pTHfNouLtWZG7j9rPN8=",
		      "Replace": null
		    },
		    {
		      "Path": "golang.org/x/net",
		      "Version": "v0.0.0-20200602114024-627f9648deb9",
		      "Sum": "h1:pNX+40auqi2JqRfOP1akLGtYcn15TUbkhwuCO3foqqM=",
		      "Replace": null
		    },
		    {
		      "Path": "golang.org/x/text",
		      "Version": "v0.3.2",
		      "Sum": "h1:tW2bmiBqwgJj/UpqtC8EpXEZVYOwU0yG4iWbprSVAcs=",
		      "Replace": null
		    },
		    {
		      "Path": "golang.org/x/xerrors",
		      "Version": "v0.0.0-20191204190536-9bdfabe68543",
		      "Sum": "h1:E7g+9GITq07hpfrRu66IVDexMakfv52eLZ2CXBWiKr4=",
		      "Replace": null
		    },
		    {
		      "Path": "gopkg.in/retry.v1",
		      "Version": "v1.0.3",
		      "Sum": "h1:a9CArYczAVv6Qs6VGoLMio99GEs7kY9UzSF9+LD+iGs=",
		      "Replace": null
		    },
		    {
		      "Path": "gopkg.in/yaml.v3",
		      "Version": "v3.0.0-20200121175148-a6ecf24a6d71",
		      "Sum": "h1:Xe2gvTZUJpsvOWUnvmL/tmhVBZUmHSvLbMjRj6NUUKo=",
		      "Replace": null
		    }
		  ]
		}
		"""
	Variables: ["GITEA_USERNAME", "GITEA_PRIV_KEY", "GITEA_PUB_KEY", "GITEA_KEYSCAN", "PAINKILLER"]
}]
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
	painkiller_go_mod_init: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "painkiller_go_mod_init"
		Order:           1
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "mkdir painkiller"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cd painkiller"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "go mod init painkiller"
			ExitCode: 0
			Output: """
				go: creating new go.mod: module painkiller

				"""
			ComparisonOutput: """
				go: creating new go.mod: module painkiller

				"""
		}]
	}
	basic_app: {
		StepType: 2
		Name:     "basic_app"
		Order:    2
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package main

			import "fmt"

			type Pill int

			const (
			\tPlacebo Pill = iota
			\tIbuprofen
			)

			func main() {
			\tfmt.Printf("For headaches, take %v\\n", Ibuprofen)
			}

			"""
		Target: "/home/gopher/painkiller/painkiller.go"
	}
	painkiller_run_basic: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "painkiller_run_basic"
		Order:           3
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				For headaches, take 1

				"""
			ComparisonOutput: """
				For headaches, take 1

				"""
		}]
	}
	manual_string: {
		StepType: 2
		Name:     "manual_string"
		Order:    4
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 3
			Pre: """
				package main

				import "fmt"

				type Pill int

				const (
				\tPlacebo Pill = iota
				\tIbuprofen
				)

				func main() {
				\tfmt.Printf("For headaches, take %v\\n", Ibuprofen)
				}

				"""
		}
		Source: """
			package main

			import "fmt"

			type Pill int

			func (p Pill) String() string {
			\tswitch p {
			\tcase Placebo:
			\t\treturn "Placebo"
			\tcase Ibuprofen:
			\t\treturn "Ibuprofen"
			\tdefault:
			\t\tpanic(fmt.Errorf("unknown Pill value %v", p))
			\t}
			}

			const (
			\tPlacebo Pill = iota
			\tIbuprofen
			)

			func main() {
			\tfmt.Printf("For headaches, take %v\\n", Ibuprofen)
			}

			"""
		Target: "/home/gopher/painkiller/painkiller.go"
	}
	painkiller_run_manual_string: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "painkiller_run_manual_string"
		Order:           5
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				For headaches, take Ibuprofen

				"""
			ComparisonOutput: """
				For headaches, take Ibuprofen

				"""
		}]
	}
	painkiller_remove_hand_written_string: {
		StepType: 2
		Name:     "painkiller_remove_hand_written_string"
		Order:    6
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 3
			Pre: """
				package main

				import "fmt"

				type Pill int

				func (p Pill) String() string {
				\tswitch p {
				\tcase Placebo:
				\t\treturn "Placebo"
				\tcase Ibuprofen:
				\t\treturn "Ibuprofen"
				\tdefault:
				\t\tpanic(fmt.Errorf("unknown Pill value %v", p))
				\t}
				}

				const (
				\tPlacebo Pill = iota
				\tIbuprofen
				)

				func main() {
				\tfmt.Printf("For headaches, take %v\\n", Ibuprofen)
				}

				"""
		}
		Source: """
			package main

			import "fmt"

			type Pill int

			const (
			\tPlacebo Pill = iota
			\tIbuprofen
			)

			func main() {
			\tfmt.Printf("For headaches, take %v\\n", Ibuprofen)
			}

			"""
		Target: "/home/gopher/painkiller/painkiller.go"
	}
	tools_go_initial: {
		StepType: 2
		Name:     "tools_go_initial"
		Order:    7
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			// +build tools

			package tools

			import (
			\t_ "golang.org/x/tools/cmd/stringer"
			)

			"""
		Target: "/home/gopher/painkiller/tools.go"
	}
	stringer_go_get: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "stringer_go_get"
		Order:           8
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go get golang.org/x/tools/cmd/stringer@v0.0.0-20201105220310-78b158585360"
			ExitCode: 0
			Output: """
				go: downloading golang.org/x/tools v0.0.0-20201105220310-78b158585360
				go: found golang.org/x/tools/cmd/stringer in golang.org/x/tools v0.0.0-20201105220310-78b158585360
				go: downloading golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1
				go: downloading golang.org/x/mod v0.3.0

				"""
			ComparisonOutput: """

				go: downloading golang.org/x/mod v0.3.0
				go: downloading golang.org/x/tools v0.0.0-20201105220310-78b158585360
				go: downloading golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1
				go: found golang.org/x/tools/cmd/stringer in golang.org/x/tools v0.0.0-20201105220310-78b158585360
				"""
		}]
	}
	painkiller_cat_go_mod: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "painkiller_cat_go_mod"
		Order:           9
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "cat go.mod"
			ExitCode: 0
			Output: """
				module painkiller

				go 1.15

				require golang.org/x/tools v0.0.0-20201105220310-78b158585360 // indirect

				"""
			ComparisonOutput: """
				module painkiller

				go 1.15

				require golang.org/x/tools v0.0.0-20201105220310-78b158585360 // indirect

				"""
		}]
	}
	painkiller_go_mod_tidy: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "painkiller_go_mod_tidy"
		Order:           10
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "go mod tidy"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	stringer_help: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "stringer_help"
		Order:           11
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go run golang.org/x/tools/cmd/stringer -help"
			ExitCode: 0
			Output: """
				Usage of stringer:
				\tstringer [flags] -type T [directory]
				\tstringer [flags] -type T files... # Must be a single package
				For more information, see:
				\thttps://pkg.go.dev/golang.org/x/tools/cmd/stringer
				Flags:
				  -linecomment
				    \tuse line comment text as printed text when present
				  -output string
				    \toutput file name; default srcdir/<type>_string.go
				  -tags string
				    \tcomma-separated list of build tags to apply
				  -trimprefix prefix
				    \ttrim the prefix from the generated constant names
				  -type string
				    \tcomma-separated list of type names; must be set

				"""
			ComparisonOutput: """
				Usage of stringer:
				\tstringer [flags] -type T [directory]
				\tstringer [flags] -type T files... # Must be a single package
				For more information, see:
				\thttps://pkg.go.dev/golang.org/x/tools/cmd/stringer
				Flags:
				  -linecomment
				    \tuse line comment text as printed text when present
				  -output string
				    \toutput file name; default srcdir/<type>_string.go
				  -tags string
				    \tcomma-separated list of build tags to apply
				  -trimprefix prefix
				    \ttrim the prefix from the generated constant names
				  -type string
				    \tcomma-separated list of type names; must be set

				"""
		}]
	}
	stringer_run_by_hand: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "stringer_run_by_hand"
		Order:           12
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "go run golang.org/x/tools/cmd/stringer -type Pill"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	stringer_ls_output: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "stringer_ls_output"
		Order:           13
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "ls"
			ExitCode: 0
			Output: """
				go.mod\tgo.sum\tpainkiller.go  pill_string.go  tools.go

				"""
			ComparisonOutput: """
				go.mod\tgo.sum\tpainkiller.go  pill_string.go  tools.go

				"""
		}]
	}
	stringer_cat_generated: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "stringer_cat_generated"
		Order:           14
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "cat pill_string.go"
			ExitCode: 0
			Output: """
				// Code generated by "stringer -type Pill"; DO NOT EDIT.

				package main

				import "strconv"

				func _() {
				\t// An "invalid array index" compiler error signifies that the constant values have changed.
				\t// Re-run the stringer command to generate them again.
				\tvar x [1]struct{}
				\t_ = x[Placebo-0]
				\t_ = x[Ibuprofen-1]
				}

				const _Pill_name = "PlaceboIbuprofen"

				var _Pill_index = [...]uint8{0, 7, 16}

				func (i Pill) String() string {
				\tif i < 0 || i >= Pill(len(_Pill_index)-1) {
				\t\treturn "Pill(" + strconv.FormatInt(int64(i), 10) + ")"
				\t}
				\treturn _Pill_name[_Pill_index[i]:_Pill_index[i+1]]
				}

				"""
			ComparisonOutput: """
				// Code generated by "stringer -type Pill"; DO NOT EDIT.

				package main

				import "strconv"

				func _() {
				\t// An "invalid array index" compiler error signifies that the constant values have changed.
				\t// Re-run the stringer command to generate them again.
				\tvar x [1]struct{}
				\t_ = x[Placebo-0]
				\t_ = x[Ibuprofen-1]
				}

				const _Pill_name = "PlaceboIbuprofen"

				var _Pill_index = [...]uint8{0, 7, 16}

				func (i Pill) String() string {
				\tif i < 0 || i >= Pill(len(_Pill_index)-1) {
				\t\treturn "Pill(" + strconv.FormatInt(int64(i), 10) + ")"
				\t}
				\treturn _Pill_name[_Pill_index[i]:_Pill_index[i+1]]
				}

				"""
		}]
	}
	painkiller_check_stringer: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "painkiller_check_stringer"
		Order:           15
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				For headaches, take Ibuprofen

				"""
			ComparisonOutput: """
				For headaches, take Ibuprofen

				"""
		}]
	}
	painkiller_add_gogenerate_directive: {
		StepType: 2
		Name:     "painkiller_add_gogenerate_directive"
		Order:    16
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 3
			Pre: """
				package main

				import "fmt"

				type Pill int

				const (
				\tPlacebo Pill = iota
				\tIbuprofen
				)

				func main() {
				\tfmt.Printf("For headaches, take %v\\n", Ibuprofen)
				}

				"""
		}
		Source: """
			package main

			import "fmt"

			//go:generate go run golang.org/x/tools/cmd/stringer -type=Pill

			type Pill int

			const (
			\tPlacebo Pill = iota
			\tIbuprofen
			)

			func main() {
			\tfmt.Printf("For headaches, take %v\\n", Ibuprofen)
			}

			"""
		Target: "/home/gopher/painkiller/painkiller.go"
	}
	painkiller_gogenerate: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "painkiller_gogenerate"
		Order:           17
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "go generate ."
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	painkiller_add_fever_advice: {
		StepType: 2
		Name:     "painkiller_add_fever_advice"
		Order:    18
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 3
			Pre: """
				package main

				import "fmt"

				//go:generate go run golang.org/x/tools/cmd/stringer -type=Pill

				type Pill int

				const (
				\tPlacebo Pill = iota
				\tIbuprofen
				)

				func main() {
				\tfmt.Printf("For headaches, take %v\\n", Ibuprofen)
				}

				"""
		}
		Source: """
			package main

			import "fmt"

			//go:generate go run golang.org/x/tools/cmd/stringer -type=Pill

			type Pill int

			const (
			\tPlacebo Pill = iota
			\tIbuprofen
			\tParacetamol
			)

			func main() {
			\tfmt.Printf("For headaches, take %v\\n", Ibuprofen)
			\tfmt.Printf("For a fever, take %v\\n", Paracetamol)
			}

			"""
		Target: "/home/gopher/painkiller/painkiller.go"
	}
	painkiller_gogenerate_again: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "painkiller_gogenerate_again"
		Order:           19
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "go generate ."
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	painkiller_check_fever_advice: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "painkiller_check_fever_advice"
		Order:           20
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				For headaches, take Ibuprofen
				For a fever, take Paracetamol

				"""
			ComparisonOutput: """
				For headaches, take Ibuprofen
				For a fever, take Paracetamol

				"""
		}]
	}
}
Hash: "241cc5e1590edf87cf72f75d2f2d7eb134f8308d4c38d5e09e9d20690e95347e"
Delims: ["{{{", "}}}"]
