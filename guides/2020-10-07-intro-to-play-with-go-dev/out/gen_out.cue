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
		      "Version": "v0.0.2-0.20201016154009-606741b7e21a",
		      "Sum": "h1:Zl9SQ1dPUvRNFYAei5hbAOadxSMLz9ppOewApK1x15I=",
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
		Hash: "6dfdf31aba32dbc226228389fdc6e7d35b1cea2ad8e0102f6200a0fd71ff54f6"
		Steps: {
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
				Order:    5
				Terminal: "term1"
				StepType: 1
				Name:     "whoami"
			}
			cat_readme: {
				Stmts: [{
					TrimmedOutput: """
						This is /home/gopher/readme.txt.

						Hello, gopher!

						We made a change!

						"""
					Output: """
						This is /home/gopher/readme.txt.

						Hello, gopher!

						We made a change!


						"""
					ExitCode: 0
					CmdStr:   "cat /home/gopher/readme.txt"
					Negated:  false
				}]
				Order:    4
				Terminal: "term1"
				StepType: 1
				Name:     "cat_readme"
			}
			upload_readme_again: {
				Order: 3
				Source: """
					This is /home/gopher/readme.txt.

					Hello, gopher!

					We made a change!

					"""
				Renderer: {
					Pre: """
						This is /home/gopher/readme.txt.

						Hello, gopher!

						"""
					RendererType: 3
				}
				Language: "txt"
				Target:   "/home/gopher/readme.txt"
				Terminal: "term1"
				StepType: 2
				Name:     "upload_readme_again"
			}
			upload_readme: {
				Order: 2
				Source: """
					This is /home/gopher/readme.txt.

					Hello, gopher!

					"""
				Renderer: {
					RendererType: 1
				}
				Language: "txt"
				Target:   "/home/gopher/readme.txt"
				Terminal: "term1"
				StepType: 2
				Name:     "upload_readme"
			}
			multiple_commands: {
				Stmts: [{
					TrimmedOutput: "Hello"
					Output: """
						Hello

						"""
					ExitCode: 0
					CmdStr:   "echo \"Hello\""
					Negated:  false
				}, {
					TrimmedOutput: "Gopher!"
					Output: """
						Gopher!

						"""
					ExitCode: 0
					CmdStr:   "echo \"Gopher!\""
					Negated:  false
				}]
				Order:    1
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
				Order:    0
				Terminal: "term1"
				StepType: 1
				Name:     "echo_hello"
			}
		}
	}
}
Delims: ["{{{", "}}}"]
