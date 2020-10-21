package out

Presteps: [{
	Variables: ["GITEA_USERNAME", "GITEA_PASSWORD", "REPO1"]
	Version: """
		{
		  "Path": "github.com/play-with-go/gitea/cmd/gitea",
		  "Main": {
		    "Path": "github.com/play-with-go/gitea",
		    "Version": "v0.0.0-20201021052016-746c46c7d2b4",
		    "Sum": "h1:a+eD8B9W9zZkAsWGfF5Bi598V6G601tA8dZJJxcLt/Q=",
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
			Pattern: "hello"
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
		Hash: "79effffa2f3beb35d142a4a371ca4bb9e1b38da197431d63ec7c8feff8695b68"
		Steps: {
			gitpush: {
				Stmts: [{
					TrimmedOutput: """
						remote: . Processing 1 references        
						remote: Processed 1 references in total        
						To https://gopher.live/{{{.GITEA_USERNAME}}}/{{{.REPO1}}}.git
						 * [new branch]      main -> main
						"""
					Output: """
						remote: . Processing 1 references        
						remote: Processed 1 references in total        
						To https://gopher.live/{{{.GITEA_USERNAME}}}/{{{.REPO1}}}.git
						 * [new branch]      main -> main

						"""
					ExitCode: 0
					CmdStr:   "git push origin main"
					Negated:  false
				}]
				Order:    8
				Terminal: "term1"
				StepType: 1
				Name:     "gitpush"
			}
			gitadd: {
				Stmts: [{
					TrimmedOutput: ""
					Output:        ""
					ExitCode:      0
					CmdStr:        "git add -A"
					Negated:       false
				}, {
					TrimmedOutput: """
						[main (root-commit) abcd123] Initial commit
						 1 file changed, 6 insertions(+)
						 create mode 100644 README.md
						"""
					Output: """
						[main (root-commit) abcd123] Initial commit
						 1 file changed, 6 insertions(+)
						 create mode 100644 README.md

						"""
					ExitCode: 0
					CmdStr:   "git commit -am 'Initial commit'"
					Negated:  false
				}]
				Order:    7
				Terminal: "term1"
				StepType: 1
				Name:     "gitadd"
			}
			gitinit: {
				Stmts: [{
					TrimmedOutput: ""
					Output:        ""
					ExitCode:      0
					CmdStr:        "git init -q"
					Negated:       false
				}, {
					TrimmedOutput: ""
					Output:        ""
					ExitCode:      0
					CmdStr:        "git remote add origin https://gopher.live/{{{.GITEA_USERNAME}}}/{{{.REPO1}}}.git"
					Negated:       false
				}]
				Order:    6
				Terminal: "term1"
				StepType: 1
				Name:     "gitinit"
			}
			cat_readme: {
				Stmts: [{
					TrimmedOutput: """
						This is README.md.

						Hello, gopher!

						We made a change!

						"""
					Output: """
						This is README.md.

						Hello, gopher!

						We made a change!


						"""
					ExitCode: 0
					CmdStr:   "cat README.md"
					Negated:  false
				}]
				Order:    5
				Terminal: "term1"
				StepType: 1
				Name:     "cat_readme"
			}
			upload_readme_again: {
				Order: 4
				Source: """
					This is README.md.

					Hello, gopher!

					We made a change!

					"""
				Renderer: {
					Pre: """
						This is README.md.

						Hello, gopher!

						"""
					RendererType: 3
				}
				Language: "md"
				Target:   "/home/gopher/hello/README.md"
				Terminal: "term1"
				StepType: 2
				Name:     "upload_readme_again"
			}
			upload_readme: {
				Order: 3
				Source: """
					This is README.md.

					Hello, gopher!

					"""
				Renderer: {
					RendererType: 1
				}
				Language: "md"
				Target:   "/home/gopher/hello/README.md"
				Terminal: "term1"
				StepType: 2
				Name:     "upload_readme"
			}
			multiple_commands: {
				Stmts: [{
					TrimmedOutput: ""
					Output:        ""
					ExitCode:      0
					CmdStr:        "mkdir hello"
					Negated:       false
				}, {
					TrimmedOutput: ""
					Output:        ""
					ExitCode:      0
					CmdStr:        "cd hello"
					Negated:       false
				}]
				Order:    2
				Terminal: "term1"
				StepType: 1
				Name:     "multiple_commands"
			}
			echo_hello: {
				Stmts: [{
					TrimmedOutput: "Hello, world!"
					Output: """
						Hello, world!

						"""
					ExitCode: 0
					CmdStr:   "echo \"Hello, world!\""
					Negated:  false
				}]
				Order:    1
				Terminal: "term1"
				StepType: 1
				Name:     "echo_hello"
			}
			whoami: {
				Stmts: [{
					TrimmedOutput: "gopher"
					Output: """
						gopher

						"""
					ExitCode: 0
					CmdStr:   "whoami"
					Negated:  false
				}, {
					TrimmedOutput: "/home/gopher"
					Output: """
						/home/gopher

						"""
					ExitCode: 0
					CmdStr:   "pwd"
					Negated:  false
				}]
				Order:    0
				Terminal: "term1"
				StepType: 1
				Name:     "whoami"
			}
		}
	}
}
Delims: ["{{{", "}}}"]
