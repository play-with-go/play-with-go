package out

Presteps: [{
	Variables: ["GITEA_USERNAME", "GITEA_PRIV_KEY", "GITEA_PUB_KEY", "GITEA_KEYSCAN", "BRANCH", "SUBDIR"]
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
		      "Version": "v0.3.0-alpha4.0.20201116194914-7463d11dea50",
		      "Sum": "h1:8FV7bhN9Nn6aq8Zkj/2nHefqGKoCbdRJ2g4NVovgZoE=",
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
		      "Version": "v0.0.2-0.20201119122857-9e30f7d3a1b3",
		      "Sum": "h1:6cyGYETrxQ78IelgO4KSOt+G4Zk9b4QVf0vsaq8TjSQ=",
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
	Args: {
		Repos: [{
			Var:     "BRANCH"
			Private: false
			Pattern: "branch"
		}, {
			Var:     "SUBDIR"
			Private: false
			Pattern: "subdir"
		}]
	}
	Package: "github.com/play-with-go/gitea"
	Path:    "/newuser"
}]
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
	gopher_run: {
		Stmts: [{
			ComparisonOutput: """
				branch.Message: branch v1
				branch/v2.Message: branch v2
				subdir.Message: subdir v1
				subdir/v2.Message: subdir v2

				"""
			Output: """
				branch.Message: branch v1
				branch/v2.Message: branch v2
				subdir.Message: subdir v1
				subdir/v2.Message: subdir v2

				"""
			ExitCode: 0
			CmdStr:   "go run ."
			Negated:  false
		}]
		Order:           18
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_run"
	}
	gopher_get_deps: {
		Stmts: [{
			ComparisonOutput: """

				go: downloading {{{.BRANCH}}} v1.0.0
				"""
			Output: """
				go: downloading {{{.BRANCH}}} v1.0.0

				"""
			ExitCode: 0
			CmdStr:   "go get {{{.BRANCH}}}@v1.0.0"
			Negated:  false
		}, {
			ComparisonOutput: """

				go: downloading {{{.BRANCH}}}/v2 v2.0.0
				"""
			Output: """
				go: downloading {{{.BRANCH}}}/v2 v2.0.0

				"""
			ExitCode: 0
			CmdStr:   "go get {{{.BRANCH}}}/v2@v2.0.0"
			Negated:  false
		}, {
			ComparisonOutput: """

				go: downloading {{{.SUBDIR}}} v1.0.0
				"""
			Output: """
				go: downloading {{{.SUBDIR}}} v1.0.0

				"""
			ExitCode: 0
			CmdStr:   "go get {{{.SUBDIR}}}@v1.0.0"
			Negated:  false
		}, {
			ComparisonOutput: """

				go: downloading {{{.SUBDIR}}}/v2 v2.0.0
				"""
			Output: """
				go: downloading {{{.SUBDIR}}}/v2 v2.0.0

				"""
			ExitCode: 0
			CmdStr:   "go get {{{.SUBDIR}}}/v2@v2.0.0"
			Negated:  false
		}]
		Order:           17
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_get_deps"
	}
	gopher_go_initial: {
		Order: 16
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
		Renderer: {
			RendererType: 1
		}
		Language: "go"
		Target:   "/home/gopher/gopher/gopher.go"
		Terminal: "term1"
		StepType: 2
		Name:     "gopher_go_initial"
	}
	gopher_init: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "mkdir /home/gopher/gopher"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/gopher"
			Negated:          false
		}, {
			ComparisonOutput: """
				go: creating new go.mod: module gopher

				"""
			Output: """
				go: creating new go.mod: module gopher

				"""
			ExitCode: 0
			CmdStr:   "go mod init gopher"
			Negated:  false
		}]
		Order:           15
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_init"
	}
	subdir_v2_commit: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git add v2"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git commit -q -m 'v2 commit of subdir module'"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git tag v2.0.0"
			Negated:          false
		}, {
			ComparisonOutput: """
				remote: .. Processing 2 references        
				remote: Processed 2 references in total        

				"""
			Output: """
				remote: .. Processing 2 references        
				remote: Processed 2 references in total        

				"""
			ExitCode: 0
			CmdStr:   "git push -q origin main v2.0.0"
			Negated:  false
		}]
		Order:           14
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "subdir_v2_commit"
	}
	subdir_go_v2: {
		Order: 13
		Source: """
			// /home/gopher/subdir/v2/subdir.go

			package subdir

			const Message = "subdir v2"

			"""
		Renderer: {
			Pre: """
				// /home/gopher/subdir/subdir.go

				package subdir

				const Message = "subdir v1"

				"""
			RendererType: 3
		}
		Language: "go"
		Target:   "/home/gopher/subdir/v2/subdir.go"
		Terminal: "term1"
		StepType: 2
		Name:     "subdir_go_v2"
	}
	subdir_go_mod_v2: {
		Order: 12
		Source: """
			// /home/gopher/subdir/v2/go.mod

			module {{{.SUBDIR}}}/v2

			go 1.15

			"""
		Renderer: {
			RendererType: 1
		}
		Language: "mod"
		Target:   "/home/gopher/subdir/v2/go.mod"
		Terminal: "term1"
		StepType: 2
		Name:     "subdir_go_mod_v2"
	}
	subdir_create_v2_subdir: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "mkdir v2"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cp go.mod subdir.go v2"
			Negated:          false
		}]
		Order:           11
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "subdir_create_v2_subdir"
	}
	subdir_initial_commit: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git add subdir.go go.mod"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git commit -q -m 'Initial commit of subdir module'"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git tag v1.0.0"
			Negated:          false
		}, {
			ComparisonOutput: """
				remote: .. Processing 2 references        
				remote: Processed 2 references in total        

				"""
			Output: """
				remote: .. Processing 2 references        
				remote: Processed 2 references in total        

				"""
			ExitCode: 0
			CmdStr:   "git push -q origin main v1.0.0"
			Negated:  false
		}]
		Order:           10
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "subdir_initial_commit"
	}
	subdir_go_initial: {
		Order: 9
		Source: """
			// /home/gopher/subdir/subdir.go

			package subdir

			const Message = "subdir v1"

			"""
		Renderer: {
			RendererType: 1
		}
		Language: "go"
		Target:   "/home/gopher/subdir/subdir.go"
		Terminal: "term1"
		StepType: 2
		Name:     "subdir_go_initial"
	}
	subdir_init: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "mkdir /home/gopher/subdir"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/subdir"
			Negated:          false
		}, {
			ComparisonOutput: """
				go: creating new go.mod: module {{{.SUBDIR}}}

				"""
			Output: """
				go: creating new go.mod: module {{{.SUBDIR}}}

				"""
			ExitCode: 0
			CmdStr:   "go mod init {{{.SUBDIR}}}"
			Negated:  false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git init -q"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git remote add origin https://{{{.SUBDIR}}}.git"
			Negated:          false
		}]
		Order:           8
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "subdir_init"
	}
	branch_v2_commit: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git add branch.go go.mod"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git commit -q -m 'v2 commit of branch module'"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git tag v2.0.0"
			Negated:          false
		}, {
			ComparisonOutput: """
				remote: .. Processing 2 references        
				remote: Processed 2 references in total        

				"""
			Output: """
				remote: .. Processing 2 references        
				remote: Processed 2 references in total        

				"""
			ExitCode: 0
			CmdStr:   "git push -q origin main v2.0.0"
			Negated:  false
		}]
		Order:           7
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "branch_v2_commit"
	}
	branch_go_v2: {
		Order: 6
		Source: """
			// /home/gopher/branch/branch.go

			package branch

			const Message = "branch v2"

			"""
		Renderer: {
			Pre: """
				// /home/gopher/branch/branch.go

				package branch

				const Message = "branch v1"

				"""
			RendererType: 3
		}
		Language: "go"
		Target:   "/home/gopher/branch/branch.go"
		Terminal: "term1"
		StepType: 2
		Name:     "branch_go_v2"
	}
	branch_go_mod_v2: {
		Order: 5
		Source: """
			// /home/gopher/branch/go.mod

			module {{{.BRANCH}}}/v2

			go 1.15

			"""
		Renderer: {
			RendererType: 1
		}
		Language: "mod"
		Target:   "/home/gopher/branch/go.mod"
		Terminal: "term1"
		StepType: 2
		Name:     "branch_go_mod_v2"
	}
	branch_create_v1_branch: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git branch main.v1"
			Negated:          false
		}, {
			ComparisonOutput: """
				remote: 
				remote: Create a new pull request for 'main.v1':        
				remote:   https://{{{.BRANCH}}}/compare/main...main.v1        
				remote: 
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
			Output: """
				remote: 
				remote: Create a new pull request for 'main.v1':        
				remote:   https://{{{.BRANCH}}}/compare/main...main.v1        
				remote: 
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
			ExitCode: 0
			CmdStr:   "git push -q origin main.v1"
			Negated:  false
		}]
		Order:           4
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "branch_create_v1_branch"
	}
	branch_initial_commit: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git add branch.go go.mod"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git commit -q -m 'Initial commit of branch module'"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git tag v1.0.0"
			Negated:          false
		}, {
			ComparisonOutput: """
				remote: .. Processing 2 references        
				remote: Processed 2 references in total        

				"""
			Output: """
				remote: .. Processing 2 references        
				remote: Processed 2 references in total        

				"""
			ExitCode: 0
			CmdStr:   "git push -q origin main v1.0.0"
			Negated:  false
		}]
		Order:           3
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "branch_initial_commit"
	}
	branch_go_initial: {
		Order: 2
		Source: """
			// /home/gopher/branch/branch.go

			package branch

			const Message = "branch v1"

			"""
		Renderer: {
			RendererType: 1
		}
		Language: "go"
		Target:   "/home/gopher/branch/branch.go"
		Terminal: "term1"
		StepType: 2
		Name:     "branch_go_initial"
	}
	branch_init: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "mkdir /home/gopher/branch"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/branch"
			Negated:          false
		}, {
			ComparisonOutput: """
				go: creating new go.mod: module {{{.BRANCH}}}

				"""
			Output: """
				go: creating new go.mod: module {{{.BRANCH}}}

				"""
			ExitCode: 0
			CmdStr:   "go mod init {{{.BRANCH}}}"
			Negated:  false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git init -q"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git remote add origin https://{{{.BRANCH}}}.git"
			Negated:          false
		}]
		Order:           1
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "branch_init"
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
Hash: "5e79c75bc1c0ac090da76b2cc7da8bda2cfd00ed65227a0324a129a44d5d772e"
Delims: ["{{{", "}}}"]
