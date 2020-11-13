package out

Presteps: [{
	Variables: ["GITEA_USERNAME", "GITEA_PASSWORD", "PUBLIC", "PRIVATE"]
	Version: """
		{
		  "Path": "github.com/play-with-go/gitea/cmd/gitea",
		  "Main": {
		    "Path": "github.com/play-with-go/gitea",
		    "Version": "v0.0.0-20201112105710-13a90a7e8526",
		    "Sum": "h1:0JH9kWYqa8pAgFfmX70kBO1IbtWPOdtUPxkfvFOB0Oo=",
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
		      "Version": "v0.0.2-0.20201112230714-c751dc0412a4",
		      "Sum": "h1:FXhUsHjzpBC9Q0ywpnKhyk9mV12dnhxanUitpWHLKxI=",
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
			Var:     "PUBLIC"
			Private: false
			Pattern: "public"
		}, {
			Var:     "PRIVATE"
			Private: true
			Pattern: "private"
		}]
	}
	Package: "github.com/play-with-go/gitea"
	Path:    "/newuser"
}]
Terminals: [{
	Description: "The main terminal"
	Scenarios: {
		go115: {
			Image: "playwithgo/go1.15.5@sha256:8d50772f8623566fa9cfa98d2a975d49cc44824c6f202ee65ab1cadf915a4445"
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
	gopher_run: {
		Stmts: [{
			ComparisonOutput: """
				public.Message(): This is a public safety announcement!
				private.Secret(): This is a top secret message... for your eyes only

				"""
			Output: """
				public.Message(): This is a public safety announcement!
				private.Secret(): This is a top secret message... for your eyes only

				"""
			ExitCode: 0
			CmdStr:   "go run ."
			Negated:  false
		}]
		Order:           22
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_run"
	}
	private_pseudo_version: {
		Stmts: [{
			ComparisonOutput: """
				v0.0.0-20060102150405-abcedf12345

				"""
			Output: """
				v0.0.0-20060102150405-abcedf12345

				"""
			ExitCode: 0
			CmdStr:   "go list -m -f {{.Version}} {{{.PRIVATE}}}"
			Negated:  false
		}]
		Order:           21
		InformationOnly: true
		DoNotTrim:       false
		RandomReplace:   "v0.0.0-20060102150405-abcedf12345"
		Terminal:        "term1"
		StepType:        1
		Name:            "private_pseudo_version"
	}
	gopher_get_private_goprivate: {
		Stmts: [{
			ComparisonOutput: """

				go: downloading {{{.PRIVATE}}} v0.0.0-20060102150405-abcedf12345
				go: {{{.PRIVATE}}} upgrade => v0.0.0-20060102150405-abcedf12345
				"""
			Output: """
				go: downloading {{{.PRIVATE}}} v0.0.0-20060102150405-abcedf12345
				go: {{{.PRIVATE}}} upgrade => v0.0.0-20060102150405-abcedf12345

				"""
			ExitCode: 0
			CmdStr:   "go get {{{.PRIVATE}}}"
			Negated:  false
		}]
		Order:           20
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_get_private_goprivate"
	}
	goprivate_set_private: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "go env -w GOPRIVATE={{{.PRIVATE}}}"
			Negated:          false
		}]
		Order:           19
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "goprivate_set_private"
	}
	gopher_get_private_direct: {
		Stmts: [{
			ComparisonOutput: """

				\t\tfatal: could not read Username for 'https://gopher.live': terminal prompts disabled
				\tnot found: {{{.PRIVATE}}}@v0.0.0-20060102150405-abcedf12345: invalid version: git fetch -f origin refs/heads/*:refs/heads/* refs/tags/*:refs/tags/* in /tmp/gopath/pkg/mod/cache/vcs/0123456789abcdef: exit status 128:
				\tserver response:
				go get {{{.PRIVATE}}}: {{{.PRIVATE}}}@v0.0.0-20060102150405-abcedf12345: verifying module: {{{.PRIVATE}}}@v0.0.0-20060102150405-abcedf12345: reading https://sum.golang.org/lookup/{{{.PRIVATE}}}@v0.0.0-20060102150405-abcedf12345: 410 Gone
				go: downloading {{{.PRIVATE}}} v0.0.0-20060102150405-abcedf12345
				"""
			Output: """
				go: downloading {{{.PRIVATE}}} v0.0.0-20060102150405-abcedf12345
				go get {{{.PRIVATE}}}: {{{.PRIVATE}}}@v0.0.0-20060102150405-abcedf12345: verifying module: {{{.PRIVATE}}}@v0.0.0-20060102150405-abcedf12345: reading https://sum.golang.org/lookup/{{{.PRIVATE}}}@v0.0.0-20060102150405-abcedf12345: 410 Gone
				\tserver response:
				\tnot found: {{{.PRIVATE}}}@v0.0.0-20060102150405-abcedf12345: invalid version: git fetch -f origin refs/heads/*:refs/heads/* refs/tags/*:refs/tags/* in /tmp/gopath/pkg/mod/cache/vcs/0123456789abcdef: exit status 128:
				\t\tfatal: could not read Username for 'https://gopher.live': terminal prompts disabled

				"""
			ExitCode: 1
			CmdStr:   "go get {{{.PRIVATE}}}"
			Negated:  true
		}]
		Order:           17
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_get_private_direct"
	}
	goproxy_proxy_default: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "go env -w GOPROXY="
			Negated:          false
		}]
		Order:           16
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "goproxy_proxy_default"
	}
	gopher_get_private_initial: {
		Stmts: [{
			ComparisonOutput: """

				\t\tfatal: could not read Username for 'https://gopher.live': terminal prompts disabled
				\tConfirm the import path was entered correctly.
				\tIf this is a private repository, see https://golang.org/doc/faq#git_https for additional information.
				\tnot found: module {{{.PRIVATE}}}: git ls-remote -q origin in /tmp/gopath/pkg/mod/cache/vcs/0123456789abcdef: exit status 128:
				\tserver response:
				go get {{{.PRIVATE}}}: module {{{.PRIVATE}}}: reading https://proxy.golang.org/{{{.PRIVATE}}}/@v/list: 410 Gone
				"""
			Output: """
				go get {{{.PRIVATE}}}: module {{{.PRIVATE}}}: reading https://proxy.golang.org/{{{.PRIVATE}}}/@v/list: 410 Gone
				\tserver response:
				\tnot found: module {{{.PRIVATE}}}: git ls-remote -q origin in /tmp/gopath/pkg/mod/cache/vcs/0123456789abcdef: exit status 128:
				\t\tfatal: could not read Username for 'https://gopher.live': terminal prompts disabled
				\tConfirm the import path was entered correctly.
				\tIf this is a private repository, see https://golang.org/doc/faq#git_https for additional information.

				"""
			ExitCode: 1
			CmdStr:   "go get {{{.PRIVATE}}}"
			Negated:  true
		}]
		Order:           15
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_get_private_initial"
	}
	public_pseudo_version: {
		Stmts: [{
			ComparisonOutput: """
				v0.0.0-20060102150405-abcedf12345

				"""
			Output: """
				v0.0.0-20060102150405-abcedf12345

				"""
			ExitCode: 0
			CmdStr:   "go list -m -f {{.Version}} {{{.PUBLIC}}}"
			Negated:  false
		}]
		Order:           14
		InformationOnly: true
		DoNotTrim:       false
		RandomReplace:   "v0.0.0-20060102150405-abcedf12345"
		Terminal:        "term1"
		StepType:        1
		Name:            "public_pseudo_version"
	}
	gopher_get_public_initial: {
		Stmts: [{
			ComparisonOutput: """

				go: downloading {{{.PUBLIC}}} v0.0.0-20060102150405-abcedf12345
				go: {{{.PUBLIC}}} upgrade => v0.0.0-20060102150405-abcedf12345
				"""
			Output: """
				go: downloading {{{.PUBLIC}}} v0.0.0-20060102150405-abcedf12345
				go: {{{.PUBLIC}}} upgrade => v0.0.0-20060102150405-abcedf12345

				"""
			ExitCode: 0
			CmdStr:   "go get {{{.PUBLIC}}}"
			Negated:  false
		}]
		Order:           13
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_get_public_initial"
	}
	goproxy_proxy_only: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "go env -w GOPROXY=https://proxy.golang.org"
			Negated:          false
		}]
		Order:           12
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "goproxy_proxy_only"
	}
	go_env_check: {
		Stmts: [{
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
			ExitCode: 0
			CmdStr:   "go help env"
			Negated:  false
		}]
		Order:           11
		InformationOnly: true
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "go_env_check"
	}
	go_env_check_gosumdb: {
		Stmts: [{
			ComparisonOutput: """
				sum.golang.org

				"""
			Output: """
				sum.golang.org

				"""
			ExitCode: 0
			CmdStr:   "go env GOSUMDB"
			Negated:  false
		}]
		Order:           10
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "go_env_check_gosumdb"
	}
	go_env_check_goproxy: {
		Stmts: [{
			ComparisonOutput: """
				https://proxy.golang.org,direct

				"""
			Output: """
				https://proxy.golang.org,direct

				"""
			ExitCode: 0
			CmdStr:   "go env GOPROXY"
			Negated:  false
		}]
		Order:           9
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "go_env_check_goproxy"
	}
	gopher_init: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "mkdir /home/gopher/gopher"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/gopher"
			Negated:          false
		}, {
			ComparisonOutput: """
				go: creating new go.mod: module gopher

				"""
			Output: """
				go: creating new go.mod: module gopher

				"""
			ExitCode: 0
			CmdStr:   "go mod init gopher"
			Negated:  false
		}]
		Order:           7
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_init"
	}
	private_initial_commit: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git add private.go"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git commit -q -m 'Initial commit of private module'"
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
		Order:           6
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "private_initial_commit"
	}
	private_go_initial: {
		Order: 5
		Source: """
			package private

			func Secret() string {
			\treturn "This is a top secret message... for your eyes only"
			}

			"""
		Renderer: {
			RendererType: 1
		}
		Language: "go"
		Target:   "/home/gopher/private/private.go"
		Terminal: "term1"
		StepType: 2
		Name:     "private_go_initial"
	}
	private_init: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "mkdir /home/gopher/private"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/private"
			Negated:          false
		}, {
			ComparisonOutput: """
				go: creating new go.mod: module private

				"""
			Output: """
				go: creating new go.mod: module private

				"""
			ExitCode: 0
			CmdStr:   "go mod init private"
			Negated:  false
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
			CmdStr:           "git remote add origin https://{{{.PRIVATE}}}.git"
			Negated:          false
		}]
		Order:           4
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "private_init"
	}
	public_initial_commit: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git add public.go"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git commit -q -m 'Initial commit of public module'"
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
		Name:            "public_initial_commit"
	}
	public_go_initial: {
		Order: 2
		Source: """
			package public

			func Message() string {
			\treturn "This is a public safety announcement!"
			}

			"""
		Renderer: {
			RendererType: 1
		}
		Language: "go"
		Target:   "/home/gopher/public/public.go"
		Terminal: "term1"
		StepType: 2
		Name:     "public_go_initial"
	}
	public_init: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "mkdir /home/gopher/public"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/public"
			Negated:          false
		}, {
			ComparisonOutput: """
				go: creating new go.mod: module public

				"""
			Output: """
				go: creating new go.mod: module public

				"""
			ExitCode: 0
			CmdStr:   "go mod init public"
			Negated:  false
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
			CmdStr:           "git remote add origin https://{{{.PUBLIC}}}.git"
			Negated:          false
		}]
		Order:           1
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "public_init"
	}
	go_help_modprivate: {
		Stmts: [{
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
			ExitCode: 0
			CmdStr:   "go help module-private"
			Negated:  false
		}]
		Order:           18
		InformationOnly: true
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "go_help_modprivate"
	}
	gopher_go_initial: {
		Order: 8
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
		Renderer: {
			RendererType: 1
		}
		Language: "go"
		Target:   "/home/gopher/gopher/gopher.go"
		Terminal: "term1"
		StepType: 2
		Name:     "gopher_go_initial"
	}
	goversion: {
		Stmts: [{
			ComparisonOutput: """
				go version go1.15.5 linux/amd64

				"""
			Output: """
				go version go1.15.5 linux/amd64

				"""
			ExitCode: 0
			CmdStr:   "go version"
			Negated:  false
		}]
		Order:           0
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "goversion"
	}
}
Hash: "4e91e65256bf39c2b4bcbddd30a701c32299139c03dde919ca27d65c92e9e1cd"
Delims: ["{{{", "}}}"]
