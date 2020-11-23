package out

Presteps: [{
	Variables: ["GITEA_USERNAME", "GITEA_PRIV_KEY", "GITEA_PUB_KEY", "GITEA_KEYSCAN", "REPO1"]
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
		      "Version": "v0.3.0-alpha5",
		      "Sum": "h1:8gY9P7bZ3EsET3t0Y0tS2rtGo8qka7jbSu5pfjl07lw=",
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
		      "Version": "v0.0.2-0.20201123103050-d71a1f64a6fa",
		      "Sum": "h1:9KuD6NosvGFf+In9ZnAInK+HclwHvSZY733tR5ZXcxo=",
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
			Var:     "REPO1"
			Private: false
			Pattern: "mod1"
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
	create_module: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "mkdir /home/gopher/mod1"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/mod1"
			Negated:          false
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
			CmdStr:           "git remote add origin https://{{{.REPO1}}}.git"
			Negated:          false
		}, {
			ComparisonOutput: """
				go: creating new go.mod: module {{{.REPO1}}}

				"""
			Output: """
				go: creating new go.mod: module {{{.REPO1}}}

				"""
			ExitCode: 0
			CmdStr:   "go mod init {{{.REPO1}}}"
			Negated:  false
		}]
		Order:           0
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "create_module"
	}
	create_readme: {
		Order:  1
		Source: "## `{{{.REPO1}}}`"
		Renderer: {
			RendererType: 1
		}
		Language: "md"
		Target:   "/home/gopher/mod1/README.md"
		Terminal: "term1"
		StepType: 2
		Name:     "create_readme"
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
	commit_and_push: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git add go.mod README.md main.go"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git commit -q -m \"Initial commit\""
			Negated:          false
		}, {
			ComparisonOutput: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
			ExitCode: 0
			CmdStr:   "git push -q origin main"
			Negated:  false
		}]
		Order:           3
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "commit_and_push"
	}
	check_porcelain: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "[ \"$(git status --porcelain)\" == \"\" ] || (git status && false)"
			Negated:          false
		}]
		Order:           4
		InformationOnly: true
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "check_porcelain"
	}
	use_module: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "mkdir /home/gopher/mod2"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/mod2"
			Negated:          false
		}, {
			ComparisonOutput: """
				go: creating new go.mod: module mod.com

				"""
			Output: """
				go: creating new go.mod: module mod.com

				"""
			ExitCode: 0
			CmdStr:   "go mod init mod.com"
			Negated:  false
		}, {
			ComparisonOutput: """

				go: downloading {{{.REPO1}}} v0.0.0-20060102150405-abcedf12345
				go: {{{.REPO1}}} upgrade => v0.0.0-20060102150405-abcedf12345
				"""
			Output: """
				go: downloading {{{.REPO1}}} v0.0.0-20060102150405-abcedf12345
				go: {{{.REPO1}}} upgrade => v0.0.0-20060102150405-abcedf12345

				"""
			ExitCode: 0
			CmdStr:   "go get {{{.REPO1}}}"
			Negated:  false
		}, {
			ComparisonOutput: """
				Hello, world!

				"""
			Output: """
				Hello, world!

				"""
			ExitCode: 0
			CmdStr:   "go run {{{.REPO1}}}"
			Negated:  false
		}]
		Order:           5
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "use_module"
	}
	mod1_pseudoversion: {
		Stmts: [{
			ComparisonOutput: """
				v0.0.0-20060102150405-abcedf12345

				"""
			Output: """
				v0.0.0-20060102150405-abcedf12345

				"""
			ExitCode: 0
			CmdStr:   "go list -m -f {{.Version}} {{{.REPO1}}}"
			Negated:  false
		}]
		Order:           6
		InformationOnly: true
		DoNotTrim:       false
		RandomReplace:   "v0.0.0-20060102150405-abcedf12345"
		Terminal:        "term1"
		StepType:        1
		Name:            "mod1_pseudoversion"
	}
}
Hash: "bf6cb7c4c3486c463a40992daf6ccbe340e0938c4b8cbd6e74b7e66a54ba4b49"
Delims: ["{{{", "}}}"]
