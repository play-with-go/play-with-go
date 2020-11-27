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
	Variables: ["GITEA_USERNAME", "GITEA_PRIV_KEY", "GITEA_PUB_KEY", "GITEA_KEYSCAN", "BRANCH", "SUBDIR"]
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
Hash: "563c3fdd6c44cabd98315c1cfb761b01c768acde3d4353c4b46112c4ed350231"
Delims: ["{{{", "}}}"]
