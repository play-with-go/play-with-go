package out

Presteps: [{
	Package: "github.com/play-with-go/gitea"
	Path:    "/newuser"
	Args: {
		Repos: [{
			Pattern: "public"
			Private: false
			Var:     "PUBLIC"
		}, {
			Pattern: "private"
			Private: true
			Var:     "PRIVATE"
		}]
	}
	Version: """
		{
		  "Path": "github.com/play-with-go/gitea/cmd/gitea",
		  "Main": {
		    "Path": "github.com/play-with-go/gitea",
		    "Version": "v0.0.0-20210220211257-449a12644e08",
		    "Sum": "h1:ifHCcwg5o8QhPmMM3bgUU/bor78pFz8LAllflNU64xI=",
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
		      "Version": "v0.3.0-beta.5.0.20210217114852-2c86835c2019",
		      "Sum": "h1:mj5d8fHqqDGVAeGwO5FeLsYAOIYL+ifjySl0v18NVyo=",
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
		      "Version": "v0.0.2-0.20210220210722-a86dc6501825",
		      "Sum": "h1:u9kzEo17KJzKwB0IK+vvthIPrDt9Hun+LqKOMfSSZrU=",
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
	Variables: ["GITEA_USERNAME", "GITEA_PRIV_KEY", "GITEA_PUB_KEY", "GITEA_KEYSCAN", "PUBLIC", "PRIVATE"]
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
	goversion: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "goversion"
		Order:           0
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go version"
			ExitCode: 0
			Output: """
				go version go1.15.8 linux/amd64

				"""
			ComparisonOutput: """
				go version go1.15.8 linux/amd64

				"""
		}]
	}
	public_init: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "public_init"
		Order:           1
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "mkdir /home/gopher/public"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cd /home/gopher/public"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "go mod init {{{.PUBLIC}}}"
			ExitCode: 0
			Output: """
				go: creating new go.mod: module {{{.PUBLIC}}}

				"""
			ComparisonOutput: """
				go: creating new go.mod: module {{{.PUBLIC}}}

				"""
		}, {
			Negated:          false
			CmdStr:           "git init -q"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git remote add origin https://{{{.PUBLIC}}}.git"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	public_go_initial: {
		StepType: 2
		Name:     "public_go_initial"
		Order:    2
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package public

			func Message() string {
			\treturn "This is a public safety announcement!"
			}

			"""
		Target: "/home/gopher/public/public.go"
	}
	public_initial_commit: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "public_initial_commit"
		Order:           3
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "git add public.go go.mod"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git commit -q -m 'Initial commit of public module'"
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
	public_check_initial_porcelain: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: true
		Name:            "public_check_initial_porcelain"
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
	private_init: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "private_init"
		Order:           5
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "mkdir /home/gopher/private"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cd /home/gopher/private"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "go mod init {{{.PRIVATE}}}"
			ExitCode: 0
			Output: """
				go: creating new go.mod: module {{{.PRIVATE}}}

				"""
			ComparisonOutput: """
				go: creating new go.mod: module {{{.PRIVATE}}}

				"""
		}, {
			Negated:          false
			CmdStr:           "git init -q"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git remote add origin https://{{{.PRIVATE}}}.git"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	private_go_initial: {
		StepType: 2
		Name:     "private_go_initial"
		Order:    6
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package private

			func Secret() string {
			\treturn "This is a top secret message... for your eyes only"
			}

			"""
		Target: "/home/gopher/private/private.go"
	}
	private_initial_commit: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "private_initial_commit"
		Order:           7
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "git add private.go go.mod"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "git commit -q -m 'Initial commit of private module'"
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
	private_check_initial_porcelain: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: true
		Name:            "private_check_initial_porcelain"
		Order:           8
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "[ \"$(git status --porcelain)\" == \"\" ] || (git status && false)"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	gopher_init: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_init"
		Order:           9
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "mkdir /home/gopher/gopher"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cd /home/gopher/gopher"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "go mod init gopher"
			ExitCode: 0
			Output: """
				go: creating new go.mod: module gopher

				"""
			ComparisonOutput: """
				go: creating new go.mod: module gopher

				"""
		}]
	}
	gopher_go_initial: {
		StepType: 2
		Name:     "gopher_go_initial"
		Order:    10
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package main

			import (
			\t"fmt"

			\t"{{{.PUBLIC}}}"
			\t"{{{.PRIVATE}}}"
			)

			func main() {
			\tfmt.Printf("public.Message(): %v\\n", public.Message())
			\tfmt.Printf("private.Secret(): %v\\n", private.Secret())
			}

			"""
		Target: "/home/gopher/gopher/gopher.go"
	}
	go_env_check_goproxy: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "go_env_check_goproxy"
		Order:           11
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go env GOPROXY"
			ExitCode: 0
			Output: """
				https://proxy.golang.org,direct

				"""
			ComparisonOutput: """
				https://proxy.golang.org,direct

				"""
		}]
	}
	go_env_check_gosumdb: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "go_env_check_gosumdb"
		Order:           12
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go env GOSUMDB"
			ExitCode: 0
			Output: """
				sum.golang.org

				"""
			ComparisonOutput: """
				sum.golang.org

				"""
		}]
	}
	go_env_check: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: true
		Name:            "go_env_check"
		Order:           13
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go help env"
			ExitCode: 0
			Output: """
				usage: go env [-json] [-u] [-w] [var ...]

				Env prints Go environment information.

				By default env prints information as a shell script
				(on Windows, a batch file). If one or more variable
				names is given as arguments, env prints the value of
				each named variable on its own line.

				The -json flag prints the environment in JSON format
				instead of as a shell script.

				The -u flag requires one or more arguments and unsets
				the default setting for the named environment variables,
				if one has been set with 'go env -w'.

				The -w flag requires one or more arguments of the
				form NAME=VALUE and changes the default settings
				of the named environment variables to the given values.

				For more about environment variables, see 'go help environment'.

				"""
			ComparisonOutput: """
				usage: go env [-json] [-u] [-w] [var ...]

				Env prints Go environment information.

				By default env prints information as a shell script
				(on Windows, a batch file). If one or more variable
				names is given as arguments, env prints the value of
				each named variable on its own line.

				The -json flag prints the environment in JSON format
				instead of as a shell script.

				The -u flag requires one or more arguments and unsets
				the default setting for the named environment variables,
				if one has been set with 'go env -w'.

				The -w flag requires one or more arguments of the
				form NAME=VALUE and changes the default settings
				of the named environment variables to the given values.

				For more about environment variables, see 'go help environment'.

				"""
		}]
	}
	goproxy_proxy_only: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "goproxy_proxy_only"
		Order:           14
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "go env -w GOPROXY=https://proxy.golang.org"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	gopher_get_public_initial: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_get_public_initial"
		Order:           15
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go get {{{.PUBLIC}}}"
			ExitCode: 0
			Output: """
				go: downloading {{{.PUBLIC}}} v0.0.0-20060102150405-abcedf12345
				go: {{{.PUBLIC}}} upgrade => v0.0.0-20060102150405-abcedf12345

				"""
			ComparisonOutput: """

				go: downloading {{{.PUBLIC}}} v0.0.0-20060102150405-abcedf12345
				go: {{{.PUBLIC}}} upgrade => v0.0.0-20060102150405-abcedf12345
				"""
		}]
	}
	public_pseudo_version: {
		StepType:        1
		RandomReplace:   "v0.0.0-20060102150405-abcedf12345"
		DoNotTrim:       false
		InformationOnly: true
		Name:            "public_pseudo_version"
		Order:           16
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go list -m -f {{.Version}} {{{.PUBLIC}}}"
			ExitCode: 0
			Output: """
				v0.0.0-20060102150405-abcedf12345

				"""
			ComparisonOutput: """
				v0.0.0-20060102150405-abcedf12345

				"""
		}]
	}
	gopher_get_private_initial: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_get_private_initial"
		Order:           17
		Terminal:        "term1"
		Stmts: [{
			Negated:  true
			CmdStr:   "go get {{{.PRIVATE}}}"
			ExitCode: 1
			Output: """
				go get {{{.PRIVATE}}}: module {{{.PRIVATE}}}: reading https://proxy.golang.org/{{{.PRIVATE}}}/@v/list: 410 Gone
				\tserver response:
				\tnot found: module {{{.PRIVATE}}}: git ls-remote -q origin in /tmp/gopath/pkg/mod/cache/vcs/0123456789abcdef: exit status 128:
				\t\tfatal: could not read Username for 'https://gopher.live': terminal prompts disabled
				\tConfirm the import path was entered correctly.
				\tIf this is a private repository, see https://golang.org/doc/faq#git_https for additional information.

				"""
			ComparisonOutput: """

				\t\tfatal: could not read Username for 'https://gopher.live': terminal prompts disabled
				\tConfirm the import path was entered correctly.
				\tIf this is a private repository, see https://golang.org/doc/faq#git_https for additional information.
				\tnot found: module {{{.PRIVATE}}}: git ls-remote -q origin in /tmp/gopath/pkg/mod/cache/vcs/0123456789abcdef: exit status 128:
				\tserver response:
				go get {{{.PRIVATE}}}: module {{{.PRIVATE}}}: reading https://proxy.golang.org/{{{.PRIVATE}}}/@v/list: 410 Gone
				"""
		}]
	}
	goproxy_proxy_default: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "goproxy_proxy_default"
		Order:           18
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "go env -w GOPROXY="
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	gopher_get_private_direct: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_get_private_direct"
		Order:           19
		Terminal:        "term1"
		Stmts: [{
			Negated:  true
			CmdStr:   "go get {{{.PRIVATE}}}"
			ExitCode: 1
			Output: """
				go: downloading {{{.PRIVATE}}} v0.0.0-20060102150405-abcedf12345
				go get {{{.PRIVATE}}}: {{{.PRIVATE}}}@v0.0.0-20060102150405-abcedf12345: verifying module: {{{.PRIVATE}}}@v0.0.0-20060102150405-abcedf12345: reading https://sum.golang.org/lookup/{{{.PRIVATE}}}@v0.0.0-20060102150405-abcedf12345: 410 Gone
				\tserver response:
				\tnot found: {{{.PRIVATE}}}@v0.0.0-20060102150405-abcedf12345: invalid version: git fetch -f origin refs/heads/*:refs/heads/* refs/tags/*:refs/tags/* in /tmp/gopath/pkg/mod/cache/vcs/0123456789abcdef: exit status 128:
				\t\tfatal: could not read Username for 'https://gopher.live': terminal prompts disabled

				"""
			ComparisonOutput: """

				\t\tfatal: could not read Username for 'https://gopher.live': terminal prompts disabled
				\tnot found: {{{.PRIVATE}}}@v0.0.0-20060102150405-abcedf12345: invalid version: git fetch -f origin refs/heads/*:refs/heads/* refs/tags/*:refs/tags/* in /tmp/gopath/pkg/mod/cache/vcs/0123456789abcdef: exit status 128:
				\tserver response:
				go get {{{.PRIVATE}}}: {{{.PRIVATE}}}@v0.0.0-20060102150405-abcedf12345: verifying module: {{{.PRIVATE}}}@v0.0.0-20060102150405-abcedf12345: reading https://sum.golang.org/lookup/{{{.PRIVATE}}}@v0.0.0-20060102150405-abcedf12345: 410 Gone
				go: downloading {{{.PRIVATE}}} v0.0.0-20060102150405-abcedf12345
				"""
		}]
	}
	go_help_modprivate: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: true
		Name:            "go_help_modprivate"
		Order:           20
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go help module-private"
			ExitCode: 0
			Output: """
				The go command defaults to downloading modules from the public Go module
				mirror at proxy.golang.org. It also defaults to validating downloaded modules,
				regardless of source, against the public Go checksum database at sum.golang.org.
				These defaults work well for publicly available source code.

				The GOPRIVATE environment variable controls which modules the go command
				considers to be private (not available publicly) and should therefore not use the
				proxy or checksum database. The variable is a comma-separated list of
				glob patterns (in the syntax of Go's path.Match) of module path prefixes.
				For example,

				\tGOPRIVATE=*.corp.example.com,rsc.io/private

				causes the go command to treat as private any module with a path prefix
				matching either pattern, including git.corp.example.com/xyzzy, rsc.io/private,
				and rsc.io/private/quux.

				The GOPRIVATE environment variable may be used by other tools as well to
				identify non-public modules. For example, an editor could use GOPRIVATE
				to decide whether to hyperlink a package import to a godoc.org page.

				For fine-grained control over module download and validation, the GONOPROXY
				and GONOSUMDB environment variables accept the same kind of glob list
				and override GOPRIVATE for the specific decision of whether to use the proxy
				and checksum database, respectively.

				For example, if a company ran a module proxy serving private modules,
				users would configure go using:

				\tGOPRIVATE=*.corp.example.com
				\tGOPROXY=proxy.example.com
				\tGONOPROXY=none

				This would tell the go command and other tools that modules beginning with
				a corp.example.com subdomain are private but that the company proxy should
				be used for downloading both public and private modules, because
				GONOPROXY has been set to a pattern that won't match any modules,
				overriding GOPRIVATE.

				The 'go env -w' command (see 'go help env') can be used to set these variables
				for future go command invocations.

				"""
			ComparisonOutput: """
				The go command defaults to downloading modules from the public Go module
				mirror at proxy.golang.org. It also defaults to validating downloaded modules,
				regardless of source, against the public Go checksum database at sum.golang.org.
				These defaults work well for publicly available source code.

				The GOPRIVATE environment variable controls which modules the go command
				considers to be private (not available publicly) and should therefore not use the
				proxy or checksum database. The variable is a comma-separated list of
				glob patterns (in the syntax of Go's path.Match) of module path prefixes.
				For example,

				\tGOPRIVATE=*.corp.example.com,rsc.io/private

				causes the go command to treat as private any module with a path prefix
				matching either pattern, including git.corp.example.com/xyzzy, rsc.io/private,
				and rsc.io/private/quux.

				The GOPRIVATE environment variable may be used by other tools as well to
				identify non-public modules. For example, an editor could use GOPRIVATE
				to decide whether to hyperlink a package import to a godoc.org page.

				For fine-grained control over module download and validation, the GONOPROXY
				and GONOSUMDB environment variables accept the same kind of glob list
				and override GOPRIVATE for the specific decision of whether to use the proxy
				and checksum database, respectively.

				For example, if a company ran a module proxy serving private modules,
				users would configure go using:

				\tGOPRIVATE=*.corp.example.com
				\tGOPROXY=proxy.example.com
				\tGONOPROXY=none

				This would tell the go command and other tools that modules beginning with
				a corp.example.com subdomain are private but that the company proxy should
				be used for downloading both public and private modules, because
				GONOPROXY has been set to a pattern that won't match any modules,
				overriding GOPRIVATE.

				The 'go env -w' command (see 'go help env') can be used to set these variables
				for future go command invocations.

				"""
		}]
	}
	goprivate_set_private: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "goprivate_set_private"
		Order:           21
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "go env -w GOPRIVATE={{{.PRIVATE}}}"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	gopher_get_private_goprivate: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_get_private_goprivate"
		Order:           22
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go get {{{.PRIVATE}}}"
			ExitCode: 0
			Output: """
				go: downloading {{{.PRIVATE}}} v0.0.0-20060102150405-abcedf12345
				go: {{{.PRIVATE}}} upgrade => v0.0.0-20060102150405-abcedf12345

				"""
			ComparisonOutput: """

				go: downloading {{{.PRIVATE}}} v0.0.0-20060102150405-abcedf12345
				go: {{{.PRIVATE}}} upgrade => v0.0.0-20060102150405-abcedf12345
				"""
		}]
	}
	private_pseudo_version: {
		StepType:        1
		RandomReplace:   "v0.0.0-20060102150405-abcedf12345"
		DoNotTrim:       false
		InformationOnly: true
		Name:            "private_pseudo_version"
		Order:           23
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go list -m -f {{.Version}} {{{.PRIVATE}}}"
			ExitCode: 0
			Output: """
				v0.0.0-20060102150405-abcedf12345

				"""
			ComparisonOutput: """
				v0.0.0-20060102150405-abcedf12345

				"""
		}]
	}
	gopher_run: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopher_run"
		Order:           24
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				public.Message(): This is a public safety announcement!
				private.Secret(): This is a top secret message... for your eyes only

				"""
			ComparisonOutput: """
				public.Message(): This is a public safety announcement!
				private.Secret(): This is a top secret message... for your eyes only

				"""
		}]
	}
}
Hash: "7df5411362111e9dbcf0142e792707bb3ffef476fe571d41404020665cf0edab"
Delims: ["{{{", "}}}"]
