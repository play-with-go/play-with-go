package out

Presteps: [{
	Package: "github.com/play-with-go/gitea"
	Path:    "/newuser"
	Args: {
		Repos: [{
			Pattern: "proverb"
			Private: false
			Var:     "PROVERB"
		}]
	}
	Version: """
		{
		  "Path": "github.com/play-with-go/gitea/cmd/gitea",
		  "Main": {
		    "Path": "github.com/play-with-go/gitea",
		    "Version": "v0.0.0-20210430163339-b27dc21b6036",
		    "Sum": "h1:7wJ+VvtJk2GU9XtFGDeVwO6ohT8l5nu5h9A6YDCec+U=",
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
		      "Version": "v0.3.2",
		      "Sum": "h1:/Am5yFDwqnaEi+g942OPM1M4/qtfVSm49wtkQbeh5Z4=",
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
		      "Version": "v0.0.2-0.20210430163307-e5ab271ba2e9",
		      "Sum": "h1:dpSLI117TKb8MdLknsUYbQjKJpP6jzBYpfKKVszCZNI=",
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
		      "Version": "v0.0.0-20201021035429-f5854403a974",
		      "Sum": "h1:IX6qOQeG5uLjB/hjjwjedwfjND0hgjPMMyO1RoIXQNI=",
		      "Replace": null
		    },
		    {
		      "Path": "golang.org/x/text",
		      "Version": "v0.3.3",
		      "Sum": "h1:cokOdA+Jmi5PJGXLlLllQSgYigAEfHXJAERHVMaCc2k=",
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
		      "Version": "v3.0.0-20200121175148-a6ecf24a6d71",
		      "Sum": "h1:Xe2gvTZUJpsvOWUnvmL/tmhVBZUmHSvLbMjRj6NUUKo=",
		      "Replace": null
		    }
		  ]
		}
		"""
	Variables: ["GITEA_USERNAME", "GITEA_PRIV_KEY", "GITEA_PUB_KEY", "GITEA_KEYSCAN", "PROVERB"]
}]
Terminals: [{
	Name:        "term1"
	Description: "The main terminal"
	Scenarios: {
		go116: {
			Image: "playwithgo/go1.16@sha256:3ae1950433998a2be8c8ce3b1cb6479e6541f1e32443447a24085cfe09e2c391"
		}
	}
}]
Scenarios: [{
	Name:        "go116"
	Description: "Go 1.16"
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
			CmdStr:   "echo Hello world!"
			ExitCode: 0
			Output: """
				Hello world!

				"""
			ComparisonOutput: """
				Hello world!

				"""
		}, {
			Negated:  false
			CmdStr:   "go version"
			ExitCode: 0
			Output: """
				go version go1.16 linux/amd64

				"""
			ComparisonOutput: """
				go version go1.16 linux/amd64

				"""
		}]
	}
	proverb_create: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "proverb_create"
		Order:           1
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "mkdir /home/gopher/proverb"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cd /home/gopher/proverb"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git init -q"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git remote add origin https://{{{.PROVERB}}}.git"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "go mod init {{{.PROVERB}}}"
			ExitCode: 0
			Output: """
				go: creating new go.mod: module {{{.PROVERB}}}

				"""
			ComparisonOutput: """
				go: creating new go.mod: module {{{.PROVERB}}}

				"""
		}]
	}
	proverb_go_initial: {
		StepType: 2
		Name:     "proverb_go_initial"
		Order:    2
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package proverb

			// Go returns a Go proverb
			func Go() string {
			\treturn "Don't communicate by sharing memory, share memory by communicating."
			}

			"""
		Target: "/home/gopher/proverb/proverb.go"
	}
	proverb_initial_commit: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "proverb_initial_commit"
		Order:           3
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "git add -A"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git commit -q -m \"Initial commit\""
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "git push -q origin main"
			ExitCode: 0
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
			ComparisonOutput: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}]
	}
	proverb_check_initial_porcelain: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: true
		Name:            "proverb_check_initial_porcelain"
		Order:           4
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "[ \"$(git status --porcelain)\" == \"\" ] || (git status && false)"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	proverb_tag_v010: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "proverb_tag_v010"
		Order:           5
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "git tag v0.1.0"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "git push -q origin v0.1.0"
			ExitCode: 0
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
			ComparisonOutput: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}]
	}
	gopher_create: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_create"
		Order:           6
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "mkdir /home/gopher/gopher"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cd /home/gopher/gopher"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "go mod init gopher"
			ExitCode: 0
			Output: """
				go: creating new go.mod: module gopher

				"""
			ComparisonOutput: """
				go: creating new go.mod: module gopher

				"""
		}]
	}
	gopher_go_initial: {
		StepType: 2
		Name:     "gopher_go_initial"
		Order:    7
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package main

			import (
			\t"fmt"

			\t"{{{.PROVERB}}}"
			)

			func main() {
			\tfmt.Println(proverb.Go())
			}

			"""
		Target: "/home/gopher/gopher/gopher.go"
	}
	gopher_add_dep_proverb_v010: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_add_dep_proverb_v010"
		Order:           8
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go get {{{.PROVERB}}}@v0.1.0"
			ExitCode: 0
			Output: """
				go: downloading {{{.PROVERB}}} v0.1.0
				go get: added {{{.PROVERB}}} v0.1.0

				"""
			ComparisonOutput: """

				go get: added {{{.PROVERB}}} v0.1.0
				go: downloading {{{.PROVERB}}} v0.1.0
				"""
		}]
	}
	gopher_run_initial: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_run_initial"
		Order:           9
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				Don't communicate by sharing memory, share memory by communicating.

				"""
			ComparisonOutput: """
				Don't communicate by sharing memory, share memory by communicating.

				"""
		}]
	}
	proverb_cd_concurrency_change: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "proverb_cd_concurrency_change"
		Order:           10
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cd /home/gopher/proverb"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	proverb_go_concurrency: {
		StepType: 2
		Name:     "proverb_go_concurrency"
		Order:    11
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 3
			Pre: """
				package proverb

				// Go returns a Go proverb
				func Go() string {
				\treturn "Don't communicate by sharing memory, share memory by communicating."
				}

				"""
		}
		Source: """
			package proverb

			// Go returns a Go proverb
			func Go() string {
			\treturn "Concurrency is parallelism."
			}

			"""
		Target: "/home/gopher/proverb/proverb.go"
	}
	proverb_concurrency_commit: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "proverb_concurrency_commit"
		Order:           12
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "git add -A"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git commit -q -m \"Switch Go proverb to something more famous\""
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "git push -q origin main"
			ExitCode: 0
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
			ComparisonOutput: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}]
	}
	proverb_check_concurrency_porcelain: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: true
		Name:            "proverb_check_concurrency_porcelain"
		Order:           13
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "[ \"$(git status --porcelain)\" == \"\" ] || (git status && false)"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	proverb_tag_v020: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "proverb_tag_v020"
		Order:           14
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "git tag v0.2.0"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "git push -q origin v0.2.0"
			ExitCode: 0
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
			ComparisonOutput: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}]
	}
	gopher_use_v020: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_use_v020"
		Order:           15
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cd /home/gopher/gopher"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "go get {{{.PROVERB}}}@v0.2.0"
			ExitCode: 0
			Output: """
				go: downloading {{{.PROVERB}}} v0.2.0
				go get: upgraded {{{.PROVERB}}} v0.1.0 => v0.2.0

				"""
			ComparisonOutput: """

				go get: upgraded {{{.PROVERB}}} v0.1.0 => v0.2.0
				go: downloading {{{.PROVERB}}} v0.2.0
				"""
		}, {
			Negated:  false
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				Concurrency is parallelism.

				"""
			ComparisonOutput: """
				Concurrency is parallelism.

				"""
		}]
	}
	proverb_return_to_retract_v020: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "proverb_return_to_retract_v020"
		Order:           16
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cd /home/gopher/proverb"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	proverb_retract_v020: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "proverb_retract_v020"
		Order:           17
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "go mod edit -retract=v0.2.0"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	proverb_cat_v020_retract: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "proverb_cat_v020_retract"
		Order:           18
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "cat go.mod"
			ExitCode: 0
			Output: """
				module {{{.PROVERB}}}

				go 1.16

				retract v0.2.0

				"""
			ComparisonOutput: """
				module {{{.PROVERB}}}

				go 1.16

				retract v0.2.0

				"""
		}]
	}
	proverb_comment_retraction: {
		StepType: 2
		Name:     "proverb_comment_retraction"
		Order:    19
		Terminal: "term1"
		Language: "go.mod"
		Renderer: {
			RendererType: 1
		}
		Source: """
			module {{{.PROVERB}}}

			go 1.16

			// Go proverb was totally wrong
			retract v0.2.0

			"""
		Target: "/home/gopher/proverb/go.mod"
	}
	proverb_go_fix_concurrency_bug: {
		StepType: 2
		Name:     "proverb_go_fix_concurrency_bug"
		Order:    20
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 3
			Pre: """
				package proverb

				// Go returns a Go proverb
				func Go() string {
				\treturn "Concurrency is parallelism."
				}

				"""
		}
		Source: """
			package proverb

			// Go returns a Go proverb
			func Go() string {
			\treturn "Concurrency is not parallelism."
			}

			"""
		Target: "/home/gopher/proverb/proverb.go"
	}
	proverb_tag_v030: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "proverb_tag_v030"
		Order:           21
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "git add -A"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git commit -q -m \"Fix severe error in Go proverb\""
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "git push -q origin main"
			ExitCode: 0
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
			ComparisonOutput: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}, {
			Negated:          false
			CmdStr:           "git tag v0.3.0"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "git push -q origin v0.3.0"
			ExitCode: 0
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
			ComparisonOutput: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}]
	}
	proverb_check_v030_porcelain: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: true
		Name:            "proverb_check_v030_porcelain"
		Order:           22
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "[ \"$(git status --porcelain)\" == \"\" ] || (git status && false)"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	gopher_use_v030: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_use_v030"
		Order:           23
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cd /home/gopher/gopher"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "go get {{{.PROVERB}}}@v0.3.0"
			ExitCode: 0
			Output: """
				go: downloading {{{.PROVERB}}} v0.3.0
				go get: upgraded {{{.PROVERB}}} v0.2.0 => v0.3.0

				"""
			ComparisonOutput: """

				go get: upgraded {{{.PROVERB}}} v0.2.0 => v0.3.0
				go: downloading {{{.PROVERB}}} v0.3.0
				"""
		}]
	}
	gopher_run_v030: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_run_v030"
		Order:           24
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				Concurrency is not parallelism.

				"""
			ComparisonOutput: """
				Concurrency is not parallelism.

				"""
		}]
	}
	gopher_sleep_on_proxy: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_sleep_on_proxy"
		Order:           25
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "sleep 1m"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	gopher_list_proverb: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_list_proverb"
		Order:           26
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go list -m -versions {{{.PROVERB}}}"
			ExitCode: 0
			Output: """
				{{{.PROVERB}}} v0.1.0 v0.3.0

				"""
			ComparisonOutput: """
				{{{.PROVERB}}} v0.1.0 v0.3.0

				"""
		}]
	}
	gopher_list_proverb_retracted: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_list_proverb_retracted"
		Order:           27
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go list -m -versions -retracted {{{.PROVERB}}}"
			ExitCode: 0
			Output: """
				{{{.PROVERB}}} v0.1.0 v0.2.0 v0.3.0

				"""
			ComparisonOutput: """
				{{{.PROVERB}}} v0.1.0 v0.2.0 v0.3.0

				"""
		}]
	}
	gopher_use_retracted_v020: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_use_retracted_v020"
		Order:           28
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go get {{{.PROVERB}}}@v0.2.0"
			ExitCode: 0
			Output: """
				go: warning: {{{.PROVERB}}}@v0.2.0: retracted by module author: Go proverb was totally wrong
				go: to switch to the latest unretracted version, run:
				\tgo get {{{.PROVERB}}}@latestgo get: downgraded {{{.PROVERB}}} v0.3.0 => v0.2.0

				"""
			ComparisonOutput: """

				\tgo get {{{.PROVERB}}}@latestgo get: downgraded {{{.PROVERB}}} v0.3.0 => v0.2.0
				go: to switch to the latest unretracted version, run:
				go: warning: {{{.PROVERB}}}@v0.2.0: retracted by module author: Go proverb was totally wrong
				"""
		}]
	}
	gopher_run_retracted_v020: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_run_retracted_v020"
		Order:           29
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				Concurrency is parallelism.

				"""
			ComparisonOutput: """
				Concurrency is parallelism.

				"""
		}]
	}
	gopher_list_versions: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_list_versions"
		Order:           30
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go list -m -u all"
			ExitCode: 0
			Output: """
				gopher
				{{{.PROVERB}}} v0.2.0 (retracted) [v0.3.0]

				"""
			ComparisonOutput: """
				gopher
				{{{.PROVERB}}} v0.2.0 (retracted) [v0.3.0]

				"""
		}]
	}
	gopher_use_latest_unretracted: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_use_latest_unretracted"
		Order:           31
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go get {{{.PROVERB}}}@latest"
			ExitCode: 0
			Output: """
				go get: upgraded {{{.PROVERB}}} v0.2.0 => v0.3.0

				"""
			ComparisonOutput: """

				go get: upgraded {{{.PROVERB}}} v0.2.0 => v0.3.0
				"""
		}]
	}
	proverb_return_life: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "proverb_return_life"
		Order:           32
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cd /home/gopher/proverb"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	proverb_go_life_advice: {
		StepType: 2
		Name:     "proverb_go_life_advice"
		Order:    33
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 3
			Pre: """
				package proverb

				// Go returns a Go proverb
				func Go() string {
				\treturn "Concurrency is not parallelism."
				}

				"""
		}
		Source: """
			package proverb

			// Go returns a Go proverb
			func Go() string {
			\treturn "Concurrency is not parallelism."
			}

			// Life returns a proverb useful for day-to-day living
			func Life() string {
			\treturn "A bird in the hand is worth two in the bush."
			}

			"""
		Target: "/home/gopher/proverb/proverb.go"
	}
	proverb_life_commit: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "proverb_life_commit"
		Order:           34
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "git add -A"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git commit -q -m \"Add Life() proverb\""
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "git push -q origin main"
			ExitCode: 0
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
			ComparisonOutput: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}]
	}
	proverb_check_v100_porcelain: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: true
		Name:            "proverb_check_v100_porcelain"
		Order:           35
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "[ \"$(git status --porcelain)\" == \"\" ] || (git status && false)"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	proverb_tag_v100: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "proverb_tag_v100"
		Order:           36
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "git tag v1.0.0"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "git push -q origin v1.0.0"
			ExitCode: 0
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
			ComparisonOutput: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}]
	}
	proverb_tag_v040: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "proverb_tag_v040"
		Order:           37
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "git tag v0.4.0"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "git push -q origin v0.4.0"
			ExitCode: 0
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
			ComparisonOutput: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}]
	}
	proverb_retract_v100: {
		StepType: 2
		Name:     "proverb_retract_v100"
		Order:    38
		Terminal: "term1"
		Language: "go.mod"
		Renderer: {
			RendererType: 3
			Pre: """
				module {{{.PROVERB}}}

				go 1.16

				// Go proverb was totally wrong
				retract v0.2.0

				"""
		}
		Source: """
			module {{{.PROVERB}}}

			go 1.16

			retract (
			\t// Go proverb was totally wrong
			\tv0.2.0

			\t// Published v1 too early
			\t[v1.0.0, v1.0.1]
			)

			"""
		Target: "/home/gopher/proverb/go.mod"
	}
	proverb_tag_v101: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "proverb_tag_v101"
		Order:           39
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "git add -A"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git commit -q -m \"Retract [v1.0.0, v1.0.1]\""
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "git push -q origin main"
			ExitCode: 0
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
			ComparisonOutput: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}, {
			Negated:          false
			CmdStr:           "git tag v1.0.1"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "git push -q origin v1.0.1"
			ExitCode: 0
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
			ComparisonOutput: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}]
	}
	proverb_check_v101_porcelain: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: true
		Name:            "proverb_check_v101_porcelain"
		Order:           40
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "[ \"$(git status --porcelain)\" == \"\" ] || (git status && false)"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	gopher_cd_use_v100: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_cd_use_v100"
		Order:           41
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cd /home/gopher/gopher"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	temp_get_v101: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: true
		Name:            "temp_get_v101"
		Order:           42
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "(cd $(mktemp -d); export GOPATH=$(mktemp -d); go mod init mod.com; go get -x {{{.PROVERB}}}@v0.4.0; go get -x {{{.PROVERB}}}@v1.0.0; go get -x {{{.PROVERB}}}@v1.0.1; sleep 1m) >/dev/null 2>&1"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	gopher_use_v101: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_use_v101"
		Order:           43
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go get {{{.PROVERB}}}@v1.0.0"
			ExitCode: 0
			Output: """
				go: downloading {{{.PROVERB}}} v1.0.0
				go: warning: {{{.PROVERB}}}@v1.0.0: retracted by module author: Published v1 too early
				go: to switch to the latest unretracted version, run:
				\tgo get {{{.PROVERB}}}@latestgo get: upgraded {{{.PROVERB}}} v0.3.0 => v1.0.0

				"""
			ComparisonOutput: """

				\tgo get {{{.PROVERB}}}@latestgo get: upgraded {{{.PROVERB}}} v0.3.0 => v1.0.0
				go: downloading {{{.PROVERB}}} v1.0.0
				go: to switch to the latest unretracted version, run:
				go: warning: {{{.PROVERB}}}@v1.0.0: retracted by module author: Published v1 too early
				"""
		}, {
			Negated:  false
			CmdStr:   "go get {{{.PROVERB}}}@v1.0.1"
			ExitCode: 0
			Output: """
				go: downloading {{{.PROVERB}}} v1.0.1
				go: warning: {{{.PROVERB}}}@v1.0.1: retracted by module author: Published v1 too early
				go: to switch to the latest unretracted version, run:
				\tgo get {{{.PROVERB}}}@latestgo get: upgraded {{{.PROVERB}}} v1.0.0 => v1.0.1

				"""
			ComparisonOutput: """

				\tgo get {{{.PROVERB}}}@latestgo get: upgraded {{{.PROVERB}}} v1.0.0 => v1.0.1
				go: downloading {{{.PROVERB}}} v1.0.1
				go: to switch to the latest unretracted version, run:
				go: warning: {{{.PROVERB}}}@v1.0.1: retracted by module author: Published v1 too early
				"""
		}, {
			Negated:  false
			CmdStr:   "go get {{{.PROVERB}}}@v0.4.0"
			ExitCode: 0
			Output: """
				go: downloading {{{.PROVERB}}} v0.4.0
				go get: downgraded {{{.PROVERB}}} v1.0.1 => v0.4.0

				"""
			ComparisonOutput: """

				go get: downgraded {{{.PROVERB}}} v1.0.1 => v0.4.0
				go: downloading {{{.PROVERB}}} v0.4.0
				"""
		}]
	}
	gopher_sleep_on_proxy_again: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_sleep_on_proxy_again"
		Order:           44
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "sleep 1m"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	gopher_list_proverb_v101_retracted: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_list_proverb_v101_retracted"
		Order:           45
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go list -m -versions -retracted {{{.PROVERB}}}"
			ExitCode: 0
			Output: """
				{{{.PROVERB}}} v0.1.0 v0.2.0 v0.3.0 v0.4.0 v1.0.0 v1.0.1

				"""
			ComparisonOutput: """
				{{{.PROVERB}}} v0.1.0 v0.2.0 v0.3.0 v0.4.0 v1.0.0 v1.0.1

				"""
		}]
	}
	gopher_list_proverb_v101_nonretracted: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_list_proverb_v101_nonretracted"
		Order:           46
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go list -m -versions {{{.PROVERB}}}"
			ExitCode: 0
			Output: """
				{{{.PROVERB}}} v0.1.0 v0.3.0 v0.4.0

				"""
			ComparisonOutput: """
				{{{.PROVERB}}} v0.1.0 v0.3.0 v0.4.0

				"""
		}]
	}
	gopher_go_update_life_proverb: {
		StepType: 2
		Name:     "gopher_go_update_life_proverb"
		Order:    47
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 3
			Pre: """
				package main

				import (
				\t"fmt"

				\t"{{{.PROVERB}}}"
				)

				func main() {
				\tfmt.Println(proverb.Go())
				}

				"""
		}
		Source: """
			package main

			import (
			\t"fmt"

			\t"{{{.PROVERB}}}"
			)

			func main() {
			\tfmt.Printf("Go proverb: %v\\n", proverb.Go())
			\tfmt.Printf("Life advice: %v\\n", proverb.Life())
			}

			"""
		Target: "/home/gopher/gopher/gopher.go"
	}
	gopher_run_life_proverb: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_run_life_proverb"
		Order:           48
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				Go proverb: Concurrency is not parallelism.
				Life advice: A bird in the hand is worth two in the bush.

				"""
			ComparisonOutput: """
				Go proverb: Concurrency is not parallelism.
				Life advice: A bird in the hand is worth two in the bush.

				"""
		}]
	}
}
Hash: "60ebf1b2d3797ee0c00965521236865aadc2ee138fb7e34ac856c0ecd9d7312f"
Delims: ["{{{", "}}}"]
