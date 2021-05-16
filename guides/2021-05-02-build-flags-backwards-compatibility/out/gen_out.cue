package out

Presteps: [{
	Package: "github.com/play-with-go/gitea"
	Path:    "/newuser"
	Args: {
		Repos: [{
			Pattern: "public"
			Private: false
			Var:     "PUBLIC"
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
	Variables: ["GITEA_USERNAME", "GITEA_PRIV_KEY", "GITEA_PUB_KEY", "GITEA_KEYSCAN", "PUBLIC"]
}]
Terminals: [{
	Name:        "term1"
	Description: "The main terminal"
	Scenarios: {
		go115: {
			Image: "lala"
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
	go115version: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "go115version"
		Order:           0
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go115 version"
			ExitCode: 0
			Output: """
				go version go1.15.8 linux/amd64

				"""
			ComparisonOutput: """
				go version go1.15.8 linux/amd64

				"""
		}]
	}
	go116version: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "go116version"
		Order:           1
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go116 version"
			ExitCode: 0
			Output: """
				go version go1.16.3 linux/amd64

				"""
			ComparisonOutput: """
				go version go1.16.3 linux/amd64

				"""
		}]
	}
	go115default: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "go115default"
		Order:           2
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "alias go=go115"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	public_init: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "public_init"
		Order:           3
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "mkdir /home/gopher/public"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cd /home/gopher/public"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "go mod init {{{.PUBLIC}}}"
			ExitCode: 0
			Output: """
				go: creating new go.mod: module {{{.PUBLIC}}}

				"""
			ComparisonOutput: """
				go: creating new go.mod: module {{{.PUBLIC}}}

				"""
		}, {
			Negated:          false
			CmdStr:           "git init -q"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git remote add origin https://{{{.PUBLIC}}}.git"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	public_go_initial: {
		StepType: 2
		Name:     "public_go_initial"
		Order:    4
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package public

			import (
			    "fmt"
			    "io/ioutil"
			)

			func DoSomething() {
			    fmt.Fprintf(ioutil.Discard, "This doesn't print anything")
			}
			"""
		Target: "/home/gopher/public/public.go"
	}
	public_initial_commit: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "public_initial_commit"
		Order:           5
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "git add public.go go.mod"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git commit -q -m 'Initial commit of public module'"
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
	public_check_initial_porcelain: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: true
		Name:            "public_check_initial_porcelain"
		Order:           6
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "[ \"$(git status --porcelain)\" == \"\" ] || (git status && false)"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	gopher_init: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_init"
		Order:           7
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
		Order:    8
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package main

			import (

			"{{{.PUBLIC}}}"
			)

			func main() {
			    public.DoSomething()
			}

			"""
		Target: "/home/gopher/gopher/gopher.go"
	}
	gopher_run: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_run"
		Order:           9
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				go: finding module for package {{{.PUBLIC}}}
				go: downloading {{{.PUBLIC}}} v0.0.0-20210516021259-5911e81d2353
				go: found {{{.PUBLIC}}} in {{{.PUBLIC}}} v0.0.0-20210516021259-5911e81d2353

				"""
			ComparisonOutput: """
				go: finding module for package {{{.PUBLIC}}}
				go: downloading {{{.PUBLIC}}} v0.0.0-20210516021259-5911e81d2353
				go: found {{{.PUBLIC}}} in {{{.PUBLIC}}} v0.0.0-20210516021259-5911e81d2353

				"""
		}]
	}
	go116default: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "go116default"
		Order:           10
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "alias go=go116"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	public_bump_discard: {
		StepType: 2
		Name:     "public_bump_discard"
		Order:    11
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package public

			import (
			    "fmt"
			    "io"
			)

			func DoSomething() {
			    fmt.Fprintf(io.Discard, "This doesn't print anything")
			}
			"""
		Target: "/home/gopher/public/public.go"
	}
	public_bump_commit: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "public_bump_commit"
		Order:           12
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cd /home/gopher/public"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "git checkout -b bump"
			ExitCode: 0
			Output: """
				Switched to a new branch 'bump'

				"""
			ComparisonOutput: """
				Switched to a new branch 'bump'

				"""
		}, {
			Negated:          false
			CmdStr:           "git add public.go go.mod"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git commit -q -m 'Bump public to go1.16'"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "git push -q origin bump"
			ExitCode: 0
			Output: """
				remote: 
				remote: Create a new pull request for 'bump':        
				remote:   https://{{{.PUBLIC}}}/compare/main...bump        
				remote: 
				remote: . Processing 1 references
				remote: Processed 1 references in total        

				"""
			ComparisonOutput: """
				remote: 
				remote: Create a new pull request for 'bump':        
				remote:   https://{{{.PUBLIC}}}/compare/main...bump        
				remote: 
				remote: . Processing 1 references
				remote: Processed 1 references in total        

				"""
		}]
	}
	go115default1: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "go115default1"
		Order:           13
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "alias go=go115"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	gopher_update_fail: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_update_fail"
		Order:           14
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cd /home/gopher/gopher"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "code=$(go get -u -v {{{.PUBLIC}}}@bump; echo $?)"
			ExitCode: 0
			Output: """
				go: {{{.PUBLIC}}} bump => v0.0.0-20210516021314-e2f48657c61e
				go: downloading {{{.PUBLIC}}} v0.0.0-20210516021314-e2f48657c61e
				{{{.PUBLIC}}}
				# {{{.PUBLIC}}}
				../go/pkg/mod/{{{.PUBLIC}}}@v0.0.0-20210516021314-e2f48657c61e/public.go:9:17: undefined: io.Discard

				"""
			ComparisonOutput: """
				go: {{{.PUBLIC}}} bump => v0.0.0-20210516021314-e2f48657c61e
				go: downloading {{{.PUBLIC}}} v0.0.0-20210516021314-e2f48657c61e
				{{{.PUBLIC}}}
				# {{{.PUBLIC}}}
				../go/pkg/mod/{{{.PUBLIC}}}@v0.0.0-20210516021314-e2f48657c61e/public.go:9:17: undefined: io.Discard

				"""
		}, {
			Negated:          false
			CmdStr:           "[ $code == 2 ] || false"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	public_rollback_mod: {
		StepType: 2
		Name:     "public_rollback_mod"
		Order:    15
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			// +build !go1.16

			package public

			import (
			    "fmt"
			    "io/ioutil"
			)

			func DoSomething() {
			    fmt.Fprintf(ioutil.Discard, "This doesn't print anything")
			}
			"""
		Target: "/home/gopher/public/public.go"
	}
	public_add_buildtag: {
		StepType: 2
		Name:     "public_add_buildtag"
		Order:    16
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			// +build go.1.16

			package public

			import (
			    "fmt"
			    "io"
			)

			func DoSomething() {
			    fmt.Fprintf(io.Discard, "This doesn't print anything")
			}
			"""
		Target: "/home/gopher/public/public_116.go"
	}
	public_fix_commit: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "public_fix_commit"
		Order:           17
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cd /home/gopher/public"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "git checkout -b bump_fix"
			ExitCode: 0
			Output: """
				Switched to a new branch 'bump_fix'

				"""
			ComparisonOutput: """
				Switched to a new branch 'bump_fix'

				"""
		}, {
			Negated:          false
			CmdStr:           "git add public.go public_116.go go.mod"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git commit -q -m 'Fix public bump to go1.16'"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "git push -q origin bump_fix"
			ExitCode: 0
			Output: """
				remote: 
				remote: Create a new pull request for 'bump_fix':        
				remote:   https://{{{.PUBLIC}}}/compare/main...bump_fix        
				remote: 
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
			ComparisonOutput: """
				remote: 
				remote: Create a new pull request for 'bump_fix':        
				remote:   https://{{{.PUBLIC}}}/compare/main...bump_fix        
				remote: 
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}]
	}
	gopher_update_ok: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_update_ok"
		Order:           18
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "cd /home/gopher/gopher"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "go get -d -v {{{.PUBLIC}}}@bump_fix"
			ExitCode: 0
			Output: """
				go: {{{.PUBLIC}}} bump_fix => v0.0.0-20210516021327-c273d5742f90
				go: downloading {{{.PUBLIC}}} v0.0.0-20210516021327-c273d5742f90

				"""
			ComparisonOutput: """

				go: downloading {{{.PUBLIC}}} v0.0.0-20210516021327-c273d5742f90
				go: {{{.PUBLIC}}} bump_fix => v0.0.0-20210516021327-c273d5742f90
				"""
		}]
	}
}
Hash: "56560623b8d127d7ac5022951e9b12235f9456b2d590fa70e9cb1321eada231d"
Delims: ["{{{", "}}}"]