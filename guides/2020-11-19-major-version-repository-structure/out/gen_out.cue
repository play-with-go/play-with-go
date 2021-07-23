package out

Presteps: [{
	Package: "github.com/play-with-go/gitea"
	Path:    "/newuser"
	Args: {
		Repos: [{
			Pattern: "branch"
			Private: false
			Var:     "BRANCH"
		}, {
			Pattern: "subdir"
			Private: false
			Var:     "SUBDIR"
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
	Variables: ["GITEA_USERNAME", "GITEA_PRIV_KEY", "GITEA_PUB_KEY", "GITEA_KEYSCAN", "BRANCH", "SUBDIR"]
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
	branch_init: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "branch_init"
		Order:           1
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "mkdir /home/gopher/branch"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cd /home/gopher/branch"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "go mod init {{{.BRANCH}}}"
			ExitCode: 0
			Output: """
				go: creating new go.mod: module {{{.BRANCH}}}

				"""
			ComparisonOutput: """
				go: creating new go.mod: module {{{.BRANCH}}}

				"""
		}, {
			Negated:          false
			CmdStr:           "git init -q"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git remote add origin https://{{{.BRANCH}}}.git"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	branch_go_initial: {
		StepType: 2
		Name:     "branch_go_initial"
		Order:    2
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			// /home/gopher/branch/branch.go

			package branch

			const Message = "branch v1"

			"""
		Target: "/home/gopher/branch/branch.go"
	}
	branch_initial_commit: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "branch_initial_commit"
		Order:           3
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "git add branch.go go.mod"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git commit -q -m 'Initial commit of branch module'"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git tag v1.0.0"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "git push -q origin main v1.0.0"
			ExitCode: 0
			Output: """
				remote: .. Processing 2 references        
				remote: Processed 2 references in total        

				"""
			ComparisonOutput: """
				remote: .. Processing 2 references        
				remote: Processed 2 references in total        

				"""
		}]
	}
	branch_check_initial_porcelain: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: true
		Name:            "branch_check_initial_porcelain"
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
	branch_create_v1_branch: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "branch_create_v1_branch"
		Order:           5
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "git branch main.v1"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "git push -q origin main.v1"
			ExitCode: 0
			Output: """
				remote: 
				remote: Create a new pull request for 'main.v1':        
				remote:   https://{{{.BRANCH}}}/compare/main...main.v1        
				remote: 
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
			ComparisonOutput: """
				remote: 
				remote: Create a new pull request for 'main.v1':        
				remote:   https://{{{.BRANCH}}}/compare/main...main.v1        
				remote: 
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}]
	}
	branch_go_mod_v2: {
		StepType: 2
		Name:     "branch_go_mod_v2"
		Order:    6
		Terminal: "term1"
		Language: "go.mod"
		Renderer: {
			RendererType: 1
		}
		Source: """
			// /home/gopher/branch/go.mod

			module {{{.BRANCH}}}/v2

			go 1.15

			"""
		Target: "/home/gopher/branch/go.mod"
	}
	branch_go_v2: {
		StepType: 2
		Name:     "branch_go_v2"
		Order:    7
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			// /home/gopher/branch/branch.go

			package branch

			const Message = "branch v2"

			"""
		Target: "/home/gopher/branch/branch.go"
	}
	branch_v2_commit: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "branch_v2_commit"
		Order:           8
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "git add branch.go go.mod"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git commit -q -m 'v2 commit of branch module'"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git tag v2.0.0"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "git push -q origin main v2.0.0"
			ExitCode: 0
			Output: """
				remote: .. Processing 2 references        
				remote: Processed 2 references in total        

				"""
			ComparisonOutput: """
				remote: .. Processing 2 references        
				remote: Processed 2 references in total        

				"""
		}]
	}
	branch_check_v2_porcelain: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: true
		Name:            "branch_check_v2_porcelain"
		Order:           9
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "[ \"$(git status --porcelain)\" == \"\" ] || (git status && false)"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	subdir_init: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "subdir_init"
		Order:           10
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "mkdir /home/gopher/subdir"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cd /home/gopher/subdir"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "go mod init {{{.SUBDIR}}}"
			ExitCode: 0
			Output: """
				go: creating new go.mod: module {{{.SUBDIR}}}

				"""
			ComparisonOutput: """
				go: creating new go.mod: module {{{.SUBDIR}}}

				"""
		}, {
			Negated:          false
			CmdStr:           "git init -q"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git remote add origin https://{{{.SUBDIR}}}.git"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	subdir_go_initial: {
		StepType: 2
		Name:     "subdir_go_initial"
		Order:    11
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			// /home/gopher/subdir/subdir.go

			package subdir

			const Message = "subdir v1"

			"""
		Target: "/home/gopher/subdir/subdir.go"
	}
	subdir_initial_commit: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "subdir_initial_commit"
		Order:           12
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "git add subdir.go go.mod"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git commit -q -m 'Initial commit of subdir module'"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git tag v1.0.0"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "git push -q origin main v1.0.0"
			ExitCode: 0
			Output: """
				remote: .. Processing 2 references        
				remote: Processed 2 references in total        

				"""
			ComparisonOutput: """
				remote: .. Processing 2 references        
				remote: Processed 2 references in total        

				"""
		}]
	}
	subdir_check_initial_porcelain: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: true
		Name:            "subdir_check_initial_porcelain"
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
	subdir_create_v2_subdir: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "subdir_create_v2_subdir"
		Order:           14
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "mkdir v2"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cp go.mod subdir.go v2"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	subdir_go_mod_v2: {
		StepType: 2
		Name:     "subdir_go_mod_v2"
		Order:    15
		Terminal: "term1"
		Language: "go.mod"
		Renderer: {
			RendererType: 1
		}
		Source: """
			// /home/gopher/subdir/v2/go.mod

			module {{{.SUBDIR}}}/v2

			go 1.15

			"""
		Target: "/home/gopher/subdir/v2/go.mod"
	}
	subdir_go_v2: {
		StepType: 2
		Name:     "subdir_go_v2"
		Order:    16
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			// /home/gopher/subdir/v2/subdir.go

			package subdir

			const Message = "subdir v2"

			"""
		Target: "/home/gopher/subdir/v2/subdir.go"
	}
	subdir_v2_commit: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "subdir_v2_commit"
		Order:           17
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "git add v2"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git commit -q -m 'v2 commit of subdir module'"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git tag v2.0.0"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "git push -q origin main v2.0.0"
			ExitCode: 0
			Output: """
				remote: .. Processing 2 references        
				remote: Processed 2 references in total        

				"""
			ComparisonOutput: """
				remote: .. Processing 2 references        
				remote: Processed 2 references in total        

				"""
		}]
	}
	subdir_check_v2_porcelain: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: true
		Name:            "subdir_check_v2_porcelain"
		Order:           18
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
		Order:           19
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
		Order:    20
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			// /home/gopher/gopher/gopher.go

			package main

			import (
			\t"fmt"

			\tbranch "{{{.BRANCH}}}"
			\tbranch_v2 "{{{.BRANCH}}}/v2"
			\tsubdir "{{{.SUBDIR}}}"
			\tsubdir_v2 "{{{.SUBDIR}}}/v2"
			)

			func main() {
			\tfmt.Printf("branch.Message: %v\\n", branch.Message)
			\tfmt.Printf("branch/v2.Message: %v\\n", branch_v2.Message)
			\tfmt.Printf("subdir.Message: %v\\n", subdir.Message)
			\tfmt.Printf("subdir/v2.Message: %v\\n", subdir_v2.Message)
			}

			"""
		Target: "/home/gopher/gopher/gopher.go"
	}
	gopher_get_deps: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_get_deps"
		Order:           21
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go get {{{.BRANCH}}}@v1.0.0"
			ExitCode: 0
			Output: """
				go: downloading {{{.BRANCH}}} v1.0.0

				"""
			ComparisonOutput: """

				go: downloading {{{.BRANCH}}} v1.0.0
				"""
		}, {
			Negated:  false
			CmdStr:   "go get {{{.BRANCH}}}/v2@v2.0.0"
			ExitCode: 0
			Output: """
				go: downloading {{{.BRANCH}}}/v2 v2.0.0

				"""
			ComparisonOutput: """

				go: downloading {{{.BRANCH}}}/v2 v2.0.0
				"""
		}, {
			Negated:  false
			CmdStr:   "go get {{{.SUBDIR}}}@v1.0.0"
			ExitCode: 0
			Output: """
				go: downloading {{{.SUBDIR}}} v1.0.0

				"""
			ComparisonOutput: """

				go: downloading {{{.SUBDIR}}} v1.0.0
				"""
		}, {
			Negated:  false
			CmdStr:   "go get {{{.SUBDIR}}}/v2@v2.0.0"
			ExitCode: 0
			Output: """
				go: downloading {{{.SUBDIR}}}/v2 v2.0.0

				"""
			ComparisonOutput: """

				go: downloading {{{.SUBDIR}}}/v2 v2.0.0
				"""
		}]
	}
	gopher_run: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_run"
		Order:           22
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				branch.Message: branch v1
				branch/v2.Message: branch v2
				subdir.Message: subdir v1
				subdir/v2.Message: subdir v2

				"""
			ComparisonOutput: """
				branch.Message: branch v1
				branch/v2.Message: branch v2
				subdir.Message: subdir v1
				subdir/v2.Message: subdir v2

				"""
		}]
	}
}
Hash: "58eef5fe9a3b886acc1a5cacc5eb73c55a1f0777fb12d769d1449e6573fa182b"
Delims: ["{{{", "}}}"]
