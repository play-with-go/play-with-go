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
	Variables: ["GITEA_USERNAME", "GITEA_PRIV_KEY", "GITEA_PUB_KEY", "GITEA_KEYSCAN", "BRANCH", "SUBDIR"]
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
	branch_init: {
		StepType: 1
		Name:     "branch_init"
		Order:    1
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "mkdir /home/gopher/branch"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "cd /home/gopher/branch"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "go mod init {{{.BRANCH}}}"
			ExitCode: 0
			Output: """
				go: creating new go.mod: module {{{.BRANCH}}}

				"""
		}, {
			CmdStr:   "git init -q"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git remote add origin https://{{{.BRANCH}}}.git"
			ExitCode: 0
			Output:   ""
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
		StepType: 1
		Name:     "branch_initial_commit"
		Order:    3
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "git add branch.go go.mod"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git commit -q -m 'Initial commit of branch module'"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git tag v1.0.0"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git push -q origin main v1.0.0"
			ExitCode: 0
			Output: """
				remote: .. Processing 2 references        
				remote: Processed 2 references in total        

				"""
		}]
	}
	branch_check_initial_porcelain: {
		StepType:        1
		InformationOnly: true
		Name:            "branch_check_initial_porcelain"
		Order:           4
		Terminal:        "term1"
		Stmts: [{
			CmdStr:   "[ \"$(git status --porcelain)\" == \"\" ] || (git status && false)"
			ExitCode: 0
			Output:   ""
		}]
	}
	branch_create_v1_branch: {
		StepType: 1
		Name:     "branch_create_v1_branch"
		Order:    5
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "git branch main.v1"
			ExitCode: 0
			Output:   ""
		}, {
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
		StepType: 1
		Name:     "branch_v2_commit"
		Order:    8
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "git add branch.go go.mod"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git commit -q -m 'v2 commit of branch module'"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git tag v2.0.0"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git push -q origin main v2.0.0"
			ExitCode: 0
			Output: """
				remote: .. Processing 2 references        
				remote: Processed 2 references in total        

				"""
		}]
	}
	branch_check_v2_porcelain: {
		StepType:        1
		InformationOnly: true
		Name:            "branch_check_v2_porcelain"
		Order:           9
		Terminal:        "term1"
		Stmts: [{
			CmdStr:   "[ \"$(git status --porcelain)\" == \"\" ] || (git status && false)"
			ExitCode: 0
			Output:   ""
		}]
	}
	subdir_init: {
		StepType: 1
		Name:     "subdir_init"
		Order:    10
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "mkdir /home/gopher/subdir"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "cd /home/gopher/subdir"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "go mod init {{{.SUBDIR}}}"
			ExitCode: 0
			Output: """
				go: creating new go.mod: module {{{.SUBDIR}}}

				"""
		}, {
			CmdStr:   "git init -q"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git remote add origin https://{{{.SUBDIR}}}.git"
			ExitCode: 0
			Output:   ""
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
		StepType: 1
		Name:     "subdir_initial_commit"
		Order:    12
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "git add subdir.go go.mod"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git commit -q -m 'Initial commit of subdir module'"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git tag v1.0.0"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git push -q origin main v1.0.0"
			ExitCode: 0
			Output: """
				remote: .. Processing 2 references        
				remote: Processed 2 references in total        

				"""
		}]
	}
	subdir_check_initial_porcelain: {
		StepType:        1
		InformationOnly: true
		Name:            "subdir_check_initial_porcelain"
		Order:           13
		Terminal:        "term1"
		Stmts: [{
			CmdStr:   "[ \"$(git status --porcelain)\" == \"\" ] || (git status && false)"
			ExitCode: 0
			Output:   ""
		}]
	}
	subdir_create_v2_subdir: {
		StepType: 1
		Name:     "subdir_create_v2_subdir"
		Order:    14
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "mkdir v2"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "cp go.mod subdir.go v2"
			ExitCode: 0
			Output:   ""
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
		StepType: 1
		Name:     "subdir_v2_commit"
		Order:    17
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "git add v2"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git commit -q -m 'v2 commit of subdir module'"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git tag v2.0.0"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git push -q origin main v2.0.0"
			ExitCode: 0
			Output: """
				remote: .. Processing 2 references        
				remote: Processed 2 references in total        

				"""
		}]
	}
	subdir_check_v2_porcelain: {
		StepType:        1
		InformationOnly: true
		Name:            "subdir_check_v2_porcelain"
		Order:           18
		Terminal:        "term1"
		Stmts: [{
			CmdStr:   "[ \"$(git status --porcelain)\" == \"\" ] || (git status && false)"
			ExitCode: 0
			Output:   ""
		}]
	}
	gopher_init: {
		StepType: 1
		Name:     "gopher_init"
		Order:    19
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "mkdir /home/gopher/gopher"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "cd /home/gopher/gopher"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "go mod init gopher"
			ExitCode: 0
			Output: """
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
		StepType: 1
		Name:     "gopher_get_deps"
		Order:    21
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go get {{{.BRANCH}}}@v1.0.0"
			ExitCode: 0
			Output: """
				go: downloading {{{.BRANCH}}} v1.0.0
				go: added {{{.BRANCH}}} v1.0.0

				"""
		}, {
			CmdStr:   "go get {{{.BRANCH}}}/v2@v2.0.0"
			ExitCode: 0
			Output: """
				go: downloading {{{.BRANCH}}}/v2 v2.0.0
				go: added {{{.BRANCH}}}/v2 v2.0.0

				"""
		}, {
			CmdStr:   "go get {{{.SUBDIR}}}@v1.0.0"
			ExitCode: 0
			Output: """
				go: downloading {{{.SUBDIR}}} v1.0.0
				go: added {{{.SUBDIR}}} v1.0.0

				"""
		}, {
			CmdStr:   "go get {{{.SUBDIR}}}/v2@v2.0.0"
			ExitCode: 0
			Output: """
				go: downloading {{{.SUBDIR}}}/v2 v2.0.0
				go: added {{{.SUBDIR}}}/v2 v2.0.0

				"""
		}]
	}
	gopher_run: {
		StepType: 1
		Name:     "gopher_run"
		Order:    22
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				branch.Message: branch v1
				branch/v2.Message: branch v2
				subdir.Message: subdir v1
				subdir/v2.Message: subdir v2

				"""
		}]
	}
}
Hash: "3f05fa31786a39bbda64558b6fdd6069144925c39f6994d2839481793b328ac7"
Delims: ["{{{", "}}}"]
