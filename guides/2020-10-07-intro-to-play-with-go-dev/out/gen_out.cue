package out

Presteps: [{
	Variables: ["GITEA_USERNAME", "GITEA_PASSWORD", "REPO1"]
	Version: """
		{
		  "Path": "github.com/play-with-go/gitea/cmd/gitea",
		  "Main": {
		    "Path": "github.com/play-with-go/gitea",
		    "Version": "v0.0.0-20201022142910-d10ca95000af",
		    "Sum": "h1:ySGH/7q+r35IS+ERMpxhhl9q0B7846YzYqKl0yoY0WQ=",
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
		      "Version": "v0.0.2-0.20201102062751-020ecdd3c350",
		      "Sum": "h1:kGyNzPhmu4AmTO3ENqukoaPJDNVYqwByjSXiZS9QCuc=",
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
Steps: {
	gitpush: {
		Stmts: [{
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
			ExitCode: 0
			CmdStr:   "git push -q origin main"
			Negated:  false
		}]
		Order:     8
		DoNotTrim: false
		Terminal:  "term1"
		StepType:  1
		Name:      "gitpush"
	}
	gitadd: {
		Stmts: [{
			Output:   ""
			ExitCode: 0
			CmdStr:   "git add README.md"
			Negated:  false
		}, {
			Output:   ""
			ExitCode: 0
			CmdStr:   "git commit -q -m 'Initial commit'"
			Negated:  false
		}]
		Order:     7
		DoNotTrim: false
		Terminal:  "term1"
		StepType:  1
		Name:      "gitadd"
	}
	gitinit: {
		Stmts: [{
			Output:   ""
			ExitCode: 0
			CmdStr:   "git init -q"
			Negated:  false
		}, {
			Output:   ""
			ExitCode: 0
			CmdStr:   "git remote add origin https://{{{.REPO1}}}.git"
			Negated:  false
		}]
		Order:     6
		DoNotTrim: false
		Terminal:  "term1"
		StepType:  1
		Name:      "gitinit"
	}
	cat_readme: {
		Stmts: [{
			Output: """
				This is README.md.

				Hello, gopher!

				We made a change!


				"""
			ExitCode: 0
			CmdStr:   "cat README.md"
			Negated:  false
		}]
		Order:     5
		DoNotTrim: false
		Terminal:  "term1"
		StepType:  1
		Name:      "cat_readme"
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
			Output:   ""
			ExitCode: 0
			CmdStr:   "mkdir hello"
			Negated:  false
		}, {
			Output:   ""
			ExitCode: 0
			CmdStr:   "cd hello"
			Negated:  false
		}]
		Order:     2
		DoNotTrim: false
		Terminal:  "term1"
		StepType:  1
		Name:      "multiple_commands"
	}
	echo_hello: {
		Stmts: [{
			Output: """
				Hello, world!

				"""
			ExitCode: 0
			CmdStr:   "echo \"Hello, world!\""
			Negated:  false
		}]
		Order:     1
		DoNotTrim: false
		Terminal:  "term1"
		StepType:  1
		Name:      "echo_hello"
	}
	whoami: {
		Stmts: [{
			Output: """
				gopher

				"""
			ExitCode: 0
			CmdStr:   "whoami"
			Negated:  false
		}, {
			Output: """
				/home/gopher

				"""
			ExitCode: 0
			CmdStr:   "pwd"
			Negated:  false
		}]
		Order:     0
		DoNotTrim: false
		Terminal:  "term1"
		StepType:  1
		Name:      "whoami"
	}
}
Hash: "1f5c98d06b22b1018dd110b27b543101457a12a327328b8f2bafc65411abaf8c"
Delims: ["{{{", "}}}"]
