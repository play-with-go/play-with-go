package out

Presteps: [{
	Variables: ["GITEA_USERNAME", "GITEA_PASSWORD", "REPO1"]
	Version: """
		{
		  "Path": "github.com/play-with-go/gitea/cmd/gitea",
		  "Main": {
		    "Path": "github.com/play-with-go/gitea",
		    "Version": "v0.0.0-20201015075538-7787ad03373f",
		    "Sum": "h1:VXWqw1WFhU9wD7Yijr4nknfCxkOU9Fg0bkqnOLyo0TU=",
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
		      "Version": "v0.3.0-alpha4",
		      "Sum": "h1:BIPutFX2WhHXwERWZka8PZBxcl6amdKO0Vry4n5qUEc=",
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
		      "Version": "v0.0.2-0.20201020103208-9664976fa978",
		      "Sum": "h1:5SYpmpzgsPmsZI/s+axWy107fe+i2i6SVo5jXUq5c7o=",
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
			Var:     "REPO1"
			Pattern: "mod1*"
		}]
	}
	Package: "github.com/play-with-go/gitea"
	Path:    "/newuser"
}]
Terminals: [{
	Description: "The main terminal"
	Scenarios: {
		go115: {
			Image: "playwithgo/go1.15.2@sha256:4f5346af0d93f50c974d9be2f2f31c55d2f953da9437aac990d30a50e3d591a5"
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
Langs: {
	en: {
		Hash: "5e7cad6e7e721270ea14ac8617a91ba095826d3383ba2679db6df82d2070222b"
		Steps: {
			use_module: {
				Stmts: [{
					TrimmedOutput: ""
					Output:        ""
					ExitCode:      0
					CmdStr:        "mkdir /home/gopher/mod2"
					Negated:       false
				}, {
					TrimmedOutput: ""
					Output:        ""
					ExitCode:      0
					CmdStr:        "cd /home/gopher/mod2"
					Negated:       false
				}, {
					TrimmedOutput: "go: creating new go.mod: module mod.com"
					Output: """
						go: creating new go.mod: module mod.com

						"""
					ExitCode: 0
					CmdStr:   "go mod init mod.com"
					Negated:  false
				}, {
					TrimmedOutput: """
						go: downloading gopher.live/{{{.REPO1}}} v0.0.0-20060102150405-abcde12345
						go: gopher.live/{{{.REPO1}}} upgrade => v0.0.0-20060102150405-abcde12345
						"""
					Output: """
						go: downloading gopher.live/{{{.REPO1}}} v0.0.0-20060102150405-abcde12345
						go: gopher.live/{{{.REPO1}}} upgrade => v0.0.0-20060102150405-abcde12345

						"""
					ExitCode: 0
					CmdStr:   "go get gopher.live/{{{.REPO1}}}"
					Negated:  false
				}, {
					TrimmedOutput: "Hello, world!"
					Output: """
						Hello, world!

						"""
					ExitCode: 0
					CmdStr:   "go run gopher.live/{{{.REPO1}}}"
					Negated:  false
				}]
				Order:    4
				Terminal: "term1"
				StepType: 1
				Name:     "use_module"
			}
			commit_and_push: {
				Stmts: [{
					TrimmedOutput: ""
					Output:        ""
					ExitCode:      0
					CmdStr:        "git add -A"
					Negated:       false
				}, {
					TrimmedOutput: """
						[main (root-commit) abcd123] Initial commit
						 3 files changed, 11 insertions(+)
						 create mode 100644 README.md
						 create mode 100644 go.mod
						 create mode 100644 main.go
						"""
					Output: """
						[main (root-commit) abcd123] Initial commit
						 3 files changed, 11 insertions(+)
						 create mode 100644 README.md
						 create mode 100644 go.mod
						 create mode 100644 main.go

						"""
					ExitCode: 0
					CmdStr:   "git commit -m \"Initial commit\""
					Negated:  false
				}, {
					TrimmedOutput: """
						remote: . Processing 1 references        
						remote: Processed 1 references in total        
						To https://gopher.live/{{{.REPO1}}}.git
						 * [new branch]      main -> main
						Branch 'main' set up to track remote branch 'main' from 'origin'.
						"""
					Output: """
						remote: . Processing 1 references        
						remote: Processed 1 references in total        
						To https://gopher.live/{{{.REPO1}}}.git
						 * [new branch]      main -> main
						Branch 'main' set up to track remote branch 'main' from 'origin'.

						"""
					ExitCode: 0
					CmdStr:   "git push -u origin main"
					Negated:  false
				}]
				Order:    3
				Terminal: "term1"
				StepType: 1
				Name:     "commit_and_push"
			}
			create_main: {
				Order: 2
				Source: """
					package main

					import "fmt"

					func main() {
					\tfmt.Println("Hello, world!")
					}
					"""
				Renderer: {
					RendererType: 1
				}
				Language: "go"
				Target:   "/home/gopher/mod1/main.go"
				Terminal: "term1"
				StepType: 2
				Name:     "create_main"
			}
			create_readme: {
				Order:  1
				Source: "## `gopher.live/{{{.REPO1}}}`"
				Renderer: {
					RendererType: 1
				}
				Language: "md"
				Target:   "/home/gopher/mod1/README.md"
				Terminal: "term1"
				StepType: 2
				Name:     "create_readme"
			}
			create_module: {
				Stmts: [{
					TrimmedOutput: ""
					Output:        ""
					ExitCode:      0
					CmdStr:        "mkdir /home/gopher/mod1"
					Negated:       false
				}, {
					TrimmedOutput: ""
					Output:        ""
					ExitCode:      0
					CmdStr:        "cd /home/gopher/mod1"
					Negated:       false
				}, {
					TrimmedOutput: "Initialized empty Git repository in /home/gopher/mod1/.git/"
					Output: """
						Initialized empty Git repository in /home/gopher/mod1/.git/

						"""
					ExitCode: 0
					CmdStr:   "git init"
					Negated:  false
				}, {
					TrimmedOutput: ""
					Output:        ""
					ExitCode:      0
					CmdStr:        "git remote add origin https://gopher.live/{{{.REPO1}}}.git"
					Negated:       false
				}, {
					TrimmedOutput: "go: creating new go.mod: module gopher.live/{{{.REPO1}}}"
					Output: """
						go: creating new go.mod: module gopher.live/{{{.REPO1}}}

						"""
					ExitCode: 0
					CmdStr:   "go mod init gopher.live/{{{.REPO1}}}"
					Negated:  false
				}]
				Order:    0
				Terminal: "term1"
				StepType: 1
				Name:     "create_module"
			}
		}
	}
}
Delims: ["{{{", "}}}"]
