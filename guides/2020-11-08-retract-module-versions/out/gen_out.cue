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
	Variables: ["GITEA_USERNAME", "GITEA_PRIV_KEY", "GITEA_PUB_KEY", "GITEA_KEYSCAN", "PROVERB"]
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
	Description: "Go 1.16"
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
			Output: """
				go version go1.19.1 linux/amd64

				"""
		}]
	}
	proverb_create: {
		StepType: 1
		Name:     "proverb_create"
		Order:    1
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "mkdir /home/gopher/proverb"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "cd /home/gopher/proverb"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git init -q"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git remote add origin https://{{{.PROVERB}}}.git"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "go mod init {{{.PROVERB}}}"
			ExitCode: 0
			Output: """
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
		StepType: 1
		Name:     "proverb_initial_commit"
		Order:    3
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "git add -A"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git commit -q -m \"Initial commit\""
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git push -q origin main"
			ExitCode: 0
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}]
	}
	proverb_check_initial_porcelain: {
		StepType:        1
		InformationOnly: true
		Name:            "proverb_check_initial_porcelain"
		Order:           4
		Terminal:        "term1"
		Stmts: [{
			CmdStr:   "[ \"$(git status --porcelain)\" == \"\" ] || (git status && false)"
			ExitCode: 0
			Output:   ""
		}]
	}
	proverb_tag_v010: {
		StepType: 1
		Name:     "proverb_tag_v010"
		Order:    5
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "git tag v0.1.0"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git push -q origin v0.1.0"
			ExitCode: 0
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}]
	}
	gopher_create: {
		StepType: 1
		Name:     "gopher_create"
		Order:    6
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
		StepType: 1
		Name:     "gopher_add_dep_proverb_v010"
		Order:    8
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go get {{{.PROVERB}}}@v0.1.0"
			ExitCode: 0
			Output: """
				go: downloading {{{.PROVERB}}} v0.1.0
				go: added {{{.PROVERB}}} v0.1.0

				"""
		}]
	}
	gopher_run_initial: {
		StepType: 1
		Name:     "gopher_run_initial"
		Order:    9
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				Don't communicate by sharing memory, share memory by communicating.

				"""
		}]
	}
	proverb_cd_concurrency_change: {
		StepType: 1
		Name:     "proverb_cd_concurrency_change"
		Order:    10
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "cd /home/gopher/proverb"
			ExitCode: 0
			Output:   ""
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
		StepType: 1
		Name:     "proverb_concurrency_commit"
		Order:    12
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "git add -A"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git commit -q -m \"Switch Go proverb to something more famous\""
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git push -q origin main"
			ExitCode: 0
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}]
	}
	proverb_check_concurrency_porcelain: {
		StepType:        1
		InformationOnly: true
		Name:            "proverb_check_concurrency_porcelain"
		Order:           13
		Terminal:        "term1"
		Stmts: [{
			CmdStr:   "[ \"$(git status --porcelain)\" == \"\" ] || (git status && false)"
			ExitCode: 0
			Output:   ""
		}]
	}
	proverb_tag_v020: {
		StepType: 1
		Name:     "proverb_tag_v020"
		Order:    14
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "git tag v0.2.0"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git push -q origin v0.2.0"
			ExitCode: 0
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}]
	}
	gopher_use_v020: {
		StepType: 1
		Name:     "gopher_use_v020"
		Order:    15
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "cd /home/gopher/gopher"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "go get {{{.PROVERB}}}@v0.2.0"
			ExitCode: 0
			Output: """
				go: downloading {{{.PROVERB}}} v0.2.0
				go: upgraded {{{.PROVERB}}} v0.1.0 => v0.2.0

				"""
		}, {
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				Concurrency is parallelism.

				"""
		}]
	}
	proverb_return_to_retract_v020: {
		StepType: 1
		Name:     "proverb_return_to_retract_v020"
		Order:    16
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "cd /home/gopher/proverb"
			ExitCode: 0
			Output:   ""
		}]
	}
	proverb_retract_v020: {
		StepType: 1
		Name:     "proverb_retract_v020"
		Order:    17
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go mod edit -retract=v0.2.0"
			ExitCode: 0
			Output:   ""
		}]
	}
	proverb_cat_v020_retract: {
		StepType: 1
		Name:     "proverb_cat_v020_retract"
		Order:    18
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "cat go.mod"
			ExitCode: 0
			Output: """
				module {{{.PROVERB}}}

				go 1.19

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
		StepType: 1
		Name:     "proverb_tag_v030"
		Order:    21
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "git add -A"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git commit -q -m \"Fix severe error in Go proverb\""
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git push -q origin main"
			ExitCode: 0
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}, {
			CmdStr:   "git tag v0.3.0"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git push -q origin v0.3.0"
			ExitCode: 0
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}]
	}
	proverb_check_v030_porcelain: {
		StepType:        1
		InformationOnly: true
		Name:            "proverb_check_v030_porcelain"
		Order:           22
		Terminal:        "term1"
		Stmts: [{
			CmdStr:   "[ \"$(git status --porcelain)\" == \"\" ] || (git status && false)"
			ExitCode: 0
			Output:   ""
		}]
	}
	gopher_use_v030: {
		StepType: 1
		Name:     "gopher_use_v030"
		Order:    23
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "cd /home/gopher/gopher"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "go get {{{.PROVERB}}}@v0.3.0"
			ExitCode: 0
			Output: """
				go: downloading {{{.PROVERB}}} v0.3.0
				go: upgraded {{{.PROVERB}}} v0.2.0 => v0.3.0

				"""
		}]
	}
	gopher_run_v030: {
		StepType: 1
		Name:     "gopher_run_v030"
		Order:    24
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				Concurrency is not parallelism.

				"""
		}]
	}
	gopher_sleep_on_proxy: {
		StepType: 1
		Name:     "gopher_sleep_on_proxy"
		Order:    25
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "sleep 1m"
			ExitCode: 0
			Output:   ""
		}]
	}
	gopher_list_proverb: {
		StepType: 1
		Name:     "gopher_list_proverb"
		Order:    26
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go list -m -versions {{{.PROVERB}}}"
			ExitCode: 0
			Output: """
				{{{.PROVERB}}} v0.1.0 v0.3.0

				"""
		}]
	}
	gopher_list_proverb_retracted: {
		StepType: 1
		Name:     "gopher_list_proverb_retracted"
		Order:    27
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go list -m -versions -retracted {{{.PROVERB}}}"
			ExitCode: 0
			Output: """
				{{{.PROVERB}}} v0.1.0 v0.2.0 v0.3.0

				"""
		}]
	}
	gopher_use_retracted_v020: {
		StepType: 1
		Name:     "gopher_use_retracted_v020"
		Order:    28
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go get {{{.PROVERB}}}@v0.2.0"
			ExitCode: 0
			Output: """
				go: warning: {{{.PROVERB}}}@v0.2.0: retracted by module author: Go proverb was totally wrong
				go: to switch to the latest unretracted version, run:
				\tgo get {{{.PROVERB}}}@latest
				go: downgraded {{{.PROVERB}}} v0.3.0 => v0.2.0

				"""
		}]
	}
	gopher_run_retracted_v020: {
		StepType: 1
		Name:     "gopher_run_retracted_v020"
		Order:    29
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				Concurrency is parallelism.

				"""
		}]
	}
	gopher_list_versions: {
		StepType: 1
		Name:     "gopher_list_versions"
		Order:    30
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go list -m -u all"
			ExitCode: 0
			Output: """
				gopher
				{{{.PROVERB}}} v0.2.0 (retracted) [v0.3.0]

				"""
		}]
	}
	gopher_use_latest_unretracted: {
		StepType: 1
		Name:     "gopher_use_latest_unretracted"
		Order:    31
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go get {{{.PROVERB}}}@latest"
			ExitCode: 0
			Output: """
				go: upgraded {{{.PROVERB}}} v0.2.0 => v0.3.0

				"""
		}]
	}
	proverb_return_life: {
		StepType: 1
		Name:     "proverb_return_life"
		Order:    32
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "cd /home/gopher/proverb"
			ExitCode: 0
			Output:   ""
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
		StepType: 1
		Name:     "proverb_life_commit"
		Order:    34
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "git add -A"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git commit -q -m \"Add Life() proverb\""
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git push -q origin main"
			ExitCode: 0
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}]
	}
	proverb_check_v100_porcelain: {
		StepType:        1
		InformationOnly: true
		Name:            "proverb_check_v100_porcelain"
		Order:           35
		Terminal:        "term1"
		Stmts: [{
			CmdStr:   "[ \"$(git status --porcelain)\" == \"\" ] || (git status && false)"
			ExitCode: 0
			Output:   ""
		}]
	}
	proverb_tag_v100: {
		StepType: 1
		Name:     "proverb_tag_v100"
		Order:    36
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "git tag v1.0.0"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git push -q origin v1.0.0"
			ExitCode: 0
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}]
	}
	proverb_tag_v040: {
		StepType: 1
		Name:     "proverb_tag_v040"
		Order:    37
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "git tag v0.4.0"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git push -q origin v0.4.0"
			ExitCode: 0
			Output: """
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
		StepType: 1
		Name:     "proverb_tag_v101"
		Order:    39
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "git add -A"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git commit -q -m \"Retract [v1.0.0, v1.0.1]\""
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git push -q origin main"
			ExitCode: 0
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}, {
			CmdStr:   "git tag v1.0.1"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git push -q origin v1.0.1"
			ExitCode: 0
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}]
	}
	proverb_check_v101_porcelain: {
		StepType:        1
		InformationOnly: true
		Name:            "proverb_check_v101_porcelain"
		Order:           40
		Terminal:        "term1"
		Stmts: [{
			CmdStr:   "[ \"$(git status --porcelain)\" == \"\" ] || (git status && false)"
			ExitCode: 0
			Output:   ""
		}]
	}
	gopher_cd_use_v100: {
		StepType: 1
		Name:     "gopher_cd_use_v100"
		Order:    41
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "cd /home/gopher/gopher"
			ExitCode: 0
			Output:   ""
		}]
	}
	temp_get_v101: {
		StepType:        1
		InformationOnly: true
		Name:            "temp_get_v101"
		Order:           42
		Terminal:        "term1"
		Stmts: [{
			CmdStr:   "(cd $(mktemp -d); export GOPATH=$(mktemp -d); go mod init mod.com; go get -x {{{.PROVERB}}}@v0.4.0; go get -x {{{.PROVERB}}}@v1.0.0; go get -x {{{.PROVERB}}}@v1.0.1; sleep 1m) >/dev/null 2>&1"
			ExitCode: 0
			Output:   ""
		}]
	}
	gopher_use_v101: {
		StepType: 1
		Name:     "gopher_use_v101"
		Order:    43
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go get {{{.PROVERB}}}@v1.0.0"
			ExitCode: 0
			Output: """
				go: downloading {{{.PROVERB}}} v1.0.0
				go: warning: {{{.PROVERB}}}@v1.0.0: retracted by module author: Published v1 too early
				go: to switch to the latest unretracted version, run:
				\tgo get {{{.PROVERB}}}@latest
				go: upgraded {{{.PROVERB}}} v0.3.0 => v1.0.0

				"""
		}, {
			CmdStr:   "go get {{{.PROVERB}}}@v1.0.1"
			ExitCode: 0
			Output: """
				go: downloading {{{.PROVERB}}} v1.0.1
				go: warning: {{{.PROVERB}}}@v1.0.1: retracted by module author: Published v1 too early
				go: to switch to the latest unretracted version, run:
				\tgo get {{{.PROVERB}}}@latest
				go: upgraded {{{.PROVERB}}} v1.0.0 => v1.0.1

				"""
		}, {
			CmdStr:   "go get {{{.PROVERB}}}@v0.4.0"
			ExitCode: 0
			Output: """
				go: downloading {{{.PROVERB}}} v0.4.0
				go: downgraded {{{.PROVERB}}} v1.0.1 => v0.4.0

				"""
		}]
	}
	gopher_sleep_on_proxy_again: {
		StepType: 1
		Name:     "gopher_sleep_on_proxy_again"
		Order:    44
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "sleep 1m"
			ExitCode: 0
			Output:   ""
		}]
	}
	gopher_list_proverb_v101_retracted: {
		StepType: 1
		Name:     "gopher_list_proverb_v101_retracted"
		Order:    45
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go list -m -versions -retracted {{{.PROVERB}}}"
			ExitCode: 0
			Output: """
				{{{.PROVERB}}} v0.1.0 v0.2.0 v0.3.0 v0.4.0 v1.0.0 v1.0.1

				"""
		}]
	}
	gopher_list_proverb_v101_nonretracted: {
		StepType: 1
		Name:     "gopher_list_proverb_v101_nonretracted"
		Order:    46
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go list -m -versions {{{.PROVERB}}}"
			ExitCode: 0
			Output: """
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
		StepType: 1
		Name:     "gopher_run_life_proverb"
		Order:    48
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				Go proverb: Concurrency is not parallelism.
				Life advice: A bird in the hand is worth two in the bush.

				"""
		}]
	}
}
Hash: "d7b4bb98c1a487db529a3def4f4cde56cfceb482cda16bbcefd1371a144fc72a"
Delims: ["{{{", "}}}"]
