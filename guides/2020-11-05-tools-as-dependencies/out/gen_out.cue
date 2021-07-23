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
		    "Version": "v0.0.0-20210723114817-feef4e6b64a7",
		    "Sum": "h1:sEr3hyAUMVVfDG6xmHdzwSKHOL8ZpI5DJYQvbMtpZks=",
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
		      "Version": "v0.4.0",
		      "Sum": "h1:GLJblw6m2WGGCA3k1v6Wbk9gTOt2qto48ahO2MmSd6I=",
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
		      "Path": "github.com/golang/glog",
		      "Version": "v0.0.0-20160126235308-23def4e6c14b",
		      "Sum": "h1:VKtxabqXZkF25pY9ekfRL6a582T4P37/31XEstQ5p58=",
		      "Replace": null
		    },
		    {
		      "Path": "github.com/google/uuid",
		      "Version": "v1.2.0",
		      "Sum": "h1:qJYtXnJRWmpe7m/3XlyhrsLrEURqHRM2kxzoxXqyUDs=",
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
		      "Version": "v0.9.1",
		      "Sum": "h1:FEBLx1zS214owpjy7qsBeixbURkuhQAwrK5UwLGTwt4=",
		      "Replace": null
		    },
		    {
		      "Path": "github.com/play-with-go/preguide",
		      "Version": "v0.0.2-0.20210723101428-f0437229c60d",
		      "Sum": "h1:298lqYRTgb0AnzWRhXMFuAwNtoR7L60aTCNmWOyz4Gw=",
		      "Replace": null
		    },
		    {
		      "Path": "github.com/protocolbuffers/txtpbfmt",
		      "Version": "v0.0.0-20201118171849-f6a6b3f636fc",
		      "Sum": "h1:gSVONBi2HWMFXCa9jFdYvYk7IwW/mTLxWOF7rXS4LO0=",
		      "Replace": null
		    },
		    {
		      "Path": "golang.org/x/crypto",
		      "Version": "v0.0.0-20200622213623-75b288015ac9",
		      "Sum": "h1:psW17arqaxU48Z5kZ0CQnkZWQJsqcURM6tKiBApRjXI=",
		      "Replace": null
		    },
		    {
		      "Path": "golang.org/x/net",
		      "Version": "v0.0.0-20210316092652-d523dce5a7f4",
		      "Sum": "h1:b0LrWgu8+q7z4J+0Y3Umo5q1dL7NXBkKBWkaVkAq17E=",
		      "Replace": null
		    },
		    {
		      "Path": "golang.org/x/text",
		      "Version": "v0.3.6",
		      "Sum": "h1:aRYxNxv6iGQlyVaZmk6ZgYEDa+Jg18DxebPSrd6bg1M=",
		      "Replace": null
		    },
		    {
		      "Path": "golang.org/x/xerrors",
		      "Version": "v0.0.0-20200804184101-5ec99f83aff1",
		      "Sum": "h1:go1bK/D/BFZV2I8cIQd1NKEZ+0owSTG1fDTci4IqFcE=",
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
		      "Version": "v3.0.0-20200313102051-9f266ea9e77c",
		      "Sum": "h1:dUUwHk2QECo/6vqA44rthZ8ie2QXMNeKRTHCNY2nXvo=",
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
Hash: "8c19cba404ed9e40fee3d0032abdb02348ae414fe3effc22225a0eeb6fd2fb5d"
Delims: ["{{{", "}}}"]
