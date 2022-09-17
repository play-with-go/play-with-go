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
		  "GoVersion": "go1.19.1",
		  "Path": "github.com/play-with-go/gitea/cmd/gitea",
		  "Main": {
		    "Path": "github.com/play-with-go/gitea",
		    "Version": "v0.0.0-20220916095345-fddafa3403c2",
		    "Sum": "h1:hNi/ACPKXTIEOV6hn0HfelzIqwkaLWQXKSElGCi8xKE=",
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
		      "Version": "v0.0.2-0.20220918055127-cc4d80fbbfa7",
		      "Sum": "h1:83MPB7IZes5I5o7Jc2r9JBgMqHaU+E8LjHv03xehSic=",
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
	Variables: ["GITEA_USERNAME", "GITEA_PRIV_KEY", "GITEA_PUB_KEY", "GITEA_KEYSCAN", "REPO1"]
}]
Terminals: [{
	Name:        "term1"
	Description: "The main terminal"
	Scenarios: {
		go115: {
			Image: "playwithgo/go1.19.1:5966cd5f1b8ef645576f95bcb19fff827d6ca560"
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
Hash: "772eb554083abcd286edfc7be26d16d0bfefcf7a6740ab3342b60e2609d1e744"
Delims: ["{{{", "}}}"]
