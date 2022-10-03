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
		  "GoVersion": "go1.19.1",
		  "Path": "github.com/play-with-go/gitea/cmd/gitea",
		  "Main": {
		    "Path": "github.com/play-with-go/gitea",
		    "Version": "v0.0.0-20221003164140-c14d636df530",
		    "Sum": "h1:RDNvyzwtVgtV0xOEaQL+CziEPkar/gNPyQUaWdnYjGk=",
		    "Replace": null
		  },
		  "Deps": [
		    {
		      "Path": "code.gitea.io/sdk/gitea",
		      "Version": "v0.15.1",
		      "Sum": "h1:WJreC7YYuxbn0UDaPuWIe/mtiNKTvLN8MLkaw71yx/M=",
		      "Replace": null
		    },
		    {
		      "Path": "cuelang.org/go",
		      "Version": "v0.4.3",
		      "Sum": "h1:W3oBBjDTm7+IZfCKZAmC8uDG0eYfJL4Pp/xbbCMKaVo=",
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
		      "Version": "v1.2.1",
		      "Sum": "h1:zEfKbn2+PDgroKdiOzqiE8rsmLqU2uwi5PB5pBJ3TkI=",
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
		      "Version": "v0.0.2-0.20221003193111-f84a6637f25f",
		      "Sum": "h1:ijMtjVmmzO13W4+wfOng8tkYFBJN+VRuw/znwVm7x68=",
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
		      "Version": "v0.0.0-20210921155107-089bfa567519",
		      "Sum": "h1:7I4JAnoQBe7ZtJcBaYHi5UtiO8tQHbUSXxL+pnGRANg=",
		      "Replace": null
		    },
		    {
		      "Path": "golang.org/x/net",
		      "Version": "v0.0.0-20211015210444-4f30a5c0130f",
		      "Sum": "h1:OfiFi4JbukWwe3lzw+xunroH1mnC1e2Gy5cxNJApiSY=",
		      "Replace": null
		    },
		    {
		      "Path": "golang.org/x/text",
		      "Version": "v0.3.7",
		      "Sum": "h1:olpwvP2KacW1ZWvsR7uQhoyTYvKAupfQrRGBFM352Gk=",
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
		      "Version": "v3.0.0-20210107192922-496545a6307b",
		      "Sum": "h1:h8qDotaEPuJATrMmW04NCwg7v22aHH28wwpauUhK9Oo=",
		      "Replace": null
		    }
		  ],
		  "Settings": null
		}
		"""
	Variables: ["GITEA_USERNAME", "GITEA_PRIV_KEY", "GITEA_PUB_KEY", "GITEA_KEYSCAN", "PAINKILLER"]
}]
Terminals: [{
	Name:        "term1"
	Description: "The main terminal"
	Scenarios: {
		go119: {
			Image: "playwithgo/go1.19.1:6d8215b3a5eda6d3bcf338c58a26194abe18b4cd"
		}
	}
}]
Scenarios: [{
	Name:        "go119"
	Description: "Go 1.15"
}]
Networks: ["playwithgo_pwg"]
Env: []
Steps: {
	goversion: {
		StepType: 1
		Name:     "goversion"
		Order:    0
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go version"
			ExitCode: 0
			Output:   "go version go1.19.1 linux/amd64"
		}]
	}
	painkiller_go_mod_init: {
		StepType: 1
		Name:     "painkiller_go_mod_init"
		Order:    1
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "mkdir painkiller"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "cd painkiller"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "go mod init painkiller"
			ExitCode: 0
			Output: """
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
		StepType: 1
		Name:     "painkiller_run_basic"
		Order:    3
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
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
		StepType: 1
		Name:     "painkiller_run_manual_string"
		Order:    5
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
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
		StepType: 1
		Name:     "stringer_go_get"
		Order:    8
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go get golang.org/x/tools/cmd/stringer@v0.1.13-0.20220917004541-4d18923f060e"
			ExitCode: 0
			Output: """
				go: downloading golang.org/x/tools v0.1.13-0.20220917004541-4d18923f060e
				go: downloading golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f
				go: downloading golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4
				go: added golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4
				go: added golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f
				go: added golang.org/x/tools v0.1.13-0.20220917004541-4d18923f060e

				"""
		}]
	}
	painkiller_cat_go_mod: {
		StepType: 1
		Name:     "painkiller_cat_go_mod"
		Order:    9
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "cat go.mod"
			ExitCode: 0
			Output: """
				module painkiller

				go 1.19

				require (
				\tgolang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4 // indirect
				\tgolang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f // indirect
				\tgolang.org/x/tools v0.1.13-0.20220917004541-4d18923f060e // indirect
				)

				"""
		}]
	}
	painkiller_go_mod_tidy: {
		StepType: 1
		Name:     "painkiller_go_mod_tidy"
		Order:    10
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go mod tidy"
			ExitCode: 0
			Output:   ""
		}]
	}
	stringer_help: {
		StepType: 1
		Name:     "stringer_help"
		Order:    11
		Terminal: "term1"
		Stmts: [{
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
		}]
	}
	stringer_run_by_hand: {
		StepType: 1
		Name:     "stringer_run_by_hand"
		Order:    12
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go run golang.org/x/tools/cmd/stringer -type Pill"
			ExitCode: 0
			Output:   ""
		}]
	}
	stringer_ls_output: {
		StepType: 1
		Name:     "stringer_ls_output"
		Order:    13
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "ls"
			ExitCode: 0
			Output: """
				go.mod\tgo.sum\tpainkiller.go  pill_string.go  tools.go

				"""
		}]
	}
	stringer_cat_generated: {
		StepType: 1
		Name:     "stringer_cat_generated"
		Order:    14
		Terminal: "term1"
		Stmts: [{
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
		}]
	}
	painkiller_check_stringer: {
		StepType: 1
		Name:     "painkiller_check_stringer"
		Order:    15
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
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
		StepType: 1
		Name:     "painkiller_gogenerate"
		Order:    17
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go generate ."
			ExitCode: 0
			Output:   ""
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
		StepType: 1
		Name:     "painkiller_gogenerate_again"
		Order:    19
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go generate ."
			ExitCode: 0
			Output:   ""
		}]
	}
	painkiller_check_fever_advice: {
		StepType: 1
		Name:     "painkiller_check_fever_advice"
		Order:    20
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				For headaches, take Ibuprofen
				For a fever, take Paracetamol

				"""
		}]
	}
}
Hash: "90c0f116a15b1df7f7af6b38eb3484d777595b273f26ff7e9efb9f0e8010e61e"
Delims: ["{{{", "}}}"]
