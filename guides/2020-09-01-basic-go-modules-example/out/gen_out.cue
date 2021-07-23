package out

Presteps: [{
	Package: "github.com/play-with-go/gitea"
	Path:    "/newuser"
	Args: {
		Repos: [{
			Pattern: "mod1"
			Private: false
			Var:     "REPO1"
		}]
	}
	Version: """
		{
		  "Path": "github.com/play-with-go/gitea/cmd/gitea",
		  "Main": {
		    "Path": "github.com/play-with-go/gitea",
		    "Version": "v0.0.0-20210723114817-feef4e6b64a7",
		    "Sum": "h1:sEr3hyAUMVVfDG6xmHdzwSKHOL8ZpI5DJYQvbMtpZks=",
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
		      "Version": "v0.4.0",
		      "Sum": "h1:GLJblw6m2WGGCA3k1v6Wbk9gTOt2qto48ahO2MmSd6I=",
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
		      "Version": "v0.9.1",
		      "Sum": "h1:FEBLx1zS214owpjy7qsBeixbURkuhQAwrK5UwLGTwt4=",
		      "Replace": null
		    },
		    {
		      "Path": "github.com/play-with-go/preguide",
		      "Version": "v0.0.2-0.20210723101428-f0437229c60d",
		      "Sum": "h1:298lqYRTgb0AnzWRhXMFuAwNtoR7L60aTCNmWOyz4Gw=",
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
		      "Version": "v0.0.0-20200622213623-75b288015ac9",
		      "Sum": "h1:psW17arqaxU48Z5kZ0CQnkZWQJsqcURM6tKiBApRjXI=",
		      "Replace": null
		    },
		    {
		      "Path": "golang.org/x/net",
		      "Version": "v0.0.0-20210316092652-d523dce5a7f4",
		      "Sum": "h1:b0LrWgu8+q7z4J+0Y3Umo5q1dL7NXBkKBWkaVkAq17E=",
		      "Replace": null
		    },
		    {
		      "Path": "golang.org/x/text",
		      "Version": "v0.3.6",
		      "Sum": "h1:aRYxNxv6iGQlyVaZmk6ZgYEDa+Jg18DxebPSrd6bg1M=",
		      "Replace": null
		    },
		    {
		      "Path": "golang.org/x/xerrors",
		      "Version": "v0.0.0-20200804184101-5ec99f83aff1",
		      "Sum": "h1:go1bK/D/BFZV2I8cIQd1NKEZ+0owSTG1fDTci4IqFcE=",
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
		      "Version": "v3.0.0-20200313102051-9f266ea9e77c",
		      "Sum": "h1:dUUwHk2QECo/6vqA44rthZ8ie2QXMNeKRTHCNY2nXvo=",
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
			Image: "playwithgo/go1.15.8@sha256:7640da09d1555c4dddbba7f1b96051af2816e6542005176b749f38865ee0454c"
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
	create_module: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "create_module"
		Order:           0
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "mkdir /home/gopher/mod1"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cd /home/gopher/mod1"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
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
		}, {
			Negated:  false
			CmdStr:   "go mod init {{{.REPO1}}}"
			ExitCode: 0
			Output: """
				go: creating new go.mod: module {{{.REPO1}}}

				"""
			ComparisonOutput: """
				go: creating new go.mod: module {{{.REPO1}}}

				"""
		}]
	}
	create_readme: {
		StepType: 2
		Name:     "create_readme"
		Order:    1
		Terminal: "term1"
		Language: "md"
		Renderer: {
			RendererType: 1
		}
		Source: "## `{{{.REPO1}}}`"
		Target: "/home/gopher/mod1/README.md"
	}
	create_main: {
		StepType: 2
		Name:     "create_main"
		Order:    2
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package main

			import "fmt"

			func main() {
			\tfmt.Println("Hello, world!")
			}

			"""
		Target: "/home/gopher/mod1/main.go"
	}
	commit_and_push: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "commit_and_push"
		Order:           3
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "git add go.mod README.md main.go"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git commit -q -m \"Initial commit\""
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
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
	check_porcelain: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: true
		Name:            "check_porcelain"
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
	use_module: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "use_module"
		Order:           5
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "mkdir /home/gopher/mod2"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cd /home/gopher/mod2"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "go mod init mod.com"
			ExitCode: 0
			Output: """
				go: creating new go.mod: module mod.com

				"""
			ComparisonOutput: """
				go: creating new go.mod: module mod.com

				"""
		}, {
			Negated:  false
			CmdStr:   "go get {{{.REPO1}}}"
			ExitCode: 0
			Output: """
				go: downloading {{{.REPO1}}} v0.0.0-20060102150405-abcedf12345
				go: {{{.REPO1}}} upgrade => v0.0.0-20060102150405-abcedf12345

				"""
			ComparisonOutput: """

				go: downloading {{{.REPO1}}} v0.0.0-20060102150405-abcedf12345
				go: {{{.REPO1}}} upgrade => v0.0.0-20060102150405-abcedf12345
				"""
		}, {
			Negated:  false
			CmdStr:   "go run {{{.REPO1}}}"
			ExitCode: 0
			Output: """
				Hello, world!

				"""
			ComparisonOutput: """
				Hello, world!

				"""
		}]
	}
	mod1_pseudoversion: {
		StepType:        1
		RandomReplace:   "v0.0.0-20060102150405-abcedf12345"
		DoNotTrim:       false
		InformationOnly: true
		Name:            "mod1_pseudoversion"
		Order:           6
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go list -m -f {{.Version}} {{{.REPO1}}}"
			ExitCode: 0
			Output: """
				v0.0.0-20060102150405-abcedf12345

				"""
			ComparisonOutput: """
				v0.0.0-20060102150405-abcedf12345

				"""
		}]
	}
}
Hash: "b67bad6fb13ab938004c6ae17f99e6c2441aaf2904c915fa89a06ed0db7eecfe"
Delims: ["{{{", "}}}"]
