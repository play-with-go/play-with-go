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
		      "Version": "v0.0.2-0.20220926082147-a0a4ec5fe714",
		      "Sum": "h1:lNhg1ct5kMU7pPBgwQBAH9glAsbtIHUXqJElKgYLg3E=",
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
	Variables: ["GITEA_USERNAME", "GITEA_PRIV_KEY", "GITEA_PUB_KEY", "GITEA_KEYSCAN", "PUBLIC", "PRIVATE"]
}]
Terminals: [{
	Name:        "term1"
	Description: "The main terminal"
	Scenarios: {
		go119: {
			Image: "playwithgo/go1.19.1:6d8215b3a5eda6d3bcf338c58a26194abe18b4cd"
		}
	}
}]
Scenarios: [{
	Name:        "go119"
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
				go version go1.19.1 linux/amd64

				"""
			ComparisonOutput: """
				go version go1.19.1 linux/amd64

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
				go: added {{{.PUBLIC}}} v0.0.0-20060102150405-abcedf12345

				"""
			ComparisonOutput: """

				go: added {{{.PUBLIC}}} v0.0.0-20060102150405-abcedf12345
				go: downloading {{{.PUBLIC}}} v0.0.0-20060102150405-abcedf12345
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
				go: module {{{.PRIVATE}}}: reading https://proxy.golang.org/{{{.PRIVATE}}}/@v/list: 404 Not Found
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
				go: module {{{.PRIVATE}}}: reading https://proxy.golang.org/{{{.PRIVATE}}}/@v/list: 404 Not Found
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
				go: {{{.PRIVATE}}}@v0.0.0-20060102150405-abcedf12345: verifying module: {{{.PRIVATE}}}@v0.0.0-20060102150405-abcedf12345: reading https://sum.golang.org/lookup/{{{.PRIVATE}}}@v0.0.0-20060102150405-abcedf12345: 404 Not Found
				\tserver response:
				\tnot found: {{{.PRIVATE}}}@v0.0.0-20060102150405-abcedf12345: invalid version: git ls-remote -q origin in /tmp/gopath/pkg/mod/cache/vcs/0123456789abcdef: exit status 128:
				\t\tfatal: could not read Username for 'https://gopher.live': terminal prompts disabled
				\tConfirm the import path was entered correctly.
				\tIf this is a private repository, see https://golang.org/doc/faq#git_https for additional information.

				"""
			ComparisonOutput: """

				\t\tfatal: could not read Username for 'https://gopher.live': terminal prompts disabled
				\tConfirm the import path was entered correctly.
				\tIf this is a private repository, see https://golang.org/doc/faq#git_https for additional information.
				\tnot found: {{{.PRIVATE}}}@v0.0.0-20060102150405-abcedf12345: invalid version: git ls-remote -q origin in /tmp/gopath/pkg/mod/cache/vcs/0123456789abcdef: exit status 128:
				\tserver response:
				go: downloading {{{.PRIVATE}}} v0.0.0-20060102150405-abcedf12345
				go: {{{.PRIVATE}}}@v0.0.0-20060102150405-abcedf12345: verifying module: {{{.PRIVATE}}}@v0.0.0-20060102150405-abcedf12345: reading https://sum.golang.org/lookup/{{{.PRIVATE}}}@v0.0.0-20060102150405-abcedf12345: 404 Not Found
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
			CmdStr:   "go help module-auth"
			ExitCode: 0
			Output: """
				When the go command downloads a module zip file or go.mod file into the
				module cache, it computes a cryptographic hash and compares it with a known
				value to verify the file hasn't changed since it was first downloaded. Known
				hashes are stored in a file in the module root directory named go.sum. Hashes
				may also be downloaded from the checksum database depending on the values of
				GOSUMDB, GOPRIVATE, and GONOSUMDB.

				For details, see https://golang.org/ref/mod#authenticating.

				"""
			ComparisonOutput: """
				When the go command downloads a module zip file or go.mod file into the
				module cache, it computes a cryptographic hash and compares it with a known
				value to verify the file hasn't changed since it was first downloaded. Known
				hashes are stored in a file in the module root directory named go.sum. Hashes
				may also be downloaded from the checksum database depending on the values of
				GOSUMDB, GOPRIVATE, and GONOSUMDB.

				For details, see https://golang.org/ref/mod#authenticating.

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
				go: added {{{.PRIVATE}}} v0.0.0-20060102150405-abcedf12345

				"""
			ComparisonOutput: """

				go: added {{{.PRIVATE}}} v0.0.0-20060102150405-abcedf12345
				go: downloading {{{.PRIVATE}}} v0.0.0-20060102150405-abcedf12345
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
Hash: "9aa2b8b447ebeaf7eedf989bfca206f58cd8af6c0a07898908ba5a809712a662"
Delims: ["{{{", "}}}"]
