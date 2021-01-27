package out

Presteps: [{
	Package: "github.com/play-with-go/gitea"
	Path:    "/newuser"
	Args: {
		Repos: [{
			Pattern: "hello"
			Private: false
			Var:     "REPO1"
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
		      "Version": "v0.3.0-beta.3.0.20210125164657-726d93e418af",
		      "Sum": "h1:sHbIQ2HcXQMxHI0IYnizBeS90XBtFWLdmRHFr3Z/01c=",
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
		      "Version": "v0.0.2-0.20210127111707-235c877c9360",
		      "Sum": "h1:fEYeNxniikAJjUgISSADA38kW3kiL4YfQMnLEN+ZBNU=",
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
	Variables: ["GITEA_USERNAME", "GITEA_PRIV_KEY", "GITEA_PUB_KEY", "GITEA_KEYSCAN", "REPO1"]
}]
Terminals: [{
	Name:        "term1"
	Description: "The main terminal"
	Scenarios: {
		go115: {
			Image: "playwithgo/go1.15.7@sha256:29da7e55ee550cddc3f742d25756bf7ecfaa7c5a23c723f079f0c982a369fda4"
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
	whoami: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "whoami"
		Order:           0
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "whoami"
			ExitCode: 0
			Output: """
				gopher

				"""
			ComparisonOutput: """
				gopher

				"""
		}, {
			Negated:  false
			CmdStr:   "pwd"
			ExitCode: 0
			Output: """
				/home/gopher

				"""
			ComparisonOutput: """
				/home/gopher

				"""
		}]
	}
	echo_hello: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "echo_hello"
		Order:           1
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "echo '*** !!! CLICK ME !!! ***'"
			ExitCode: 0
			Output: """
				*** !!! CLICK ME !!! ***

				"""
			ComparisonOutput: """
				*** !!! CLICK ME !!! ***

				"""
		}]
	}
	multiple_commands: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "multiple_commands"
		Order:           2
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "mkdir hello"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cd hello"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	upload_readme: {
		StepType: 2
		Name:     "upload_readme"
		Order:    3
		Terminal: "term1"
		Language: "md"
		Renderer: {
			RendererType: 1
		}
		Source: """
			This is README.md.

			Hello, gopher!

			"""
		Target: "/home/gopher/hello/README.md"
	}
	upload_readme_again: {
		StepType: 2
		Name:     "upload_readme_again"
		Order:    4
		Terminal: "term1"
		Language: "md"
		Renderer: {
			RendererType: 3
			Pre: """
				This is README.md.

				Hello, gopher!

				"""
		}
		Source: """
			This is README.md.

			Hello, gopher!

			We made a change!

			"""
		Target: "/home/gopher/hello/README.md"
	}
	cat_readme: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "cat_readme"
		Order:           5
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "cat README.md"
			ExitCode: 0
			Output: """
				This is README.md.

				Hello, gopher!

				We made a change!


				"""
			ComparisonOutput: """
				This is README.md.

				Hello, gopher!

				We made a change!


				"""
		}]
	}
	gitinit: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gitinit"
		Order:           6
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "git init -q"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git remote add origin https://{{{.REPO1}}}.git"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	gitadd: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gitadd"
		Order:           7
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "git add README.md"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git commit -q -m 'Initial commit'"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	gitpush: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gitpush"
		Order:           8
		Terminal:        "term1"
		Stmts: [{
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
}
Hash: "70a021fe16ca7d7462deac8afd96ac27d5eed7162aa83a8f92472f26a2ba132f"
Delims: ["{{{", "}}}"]
