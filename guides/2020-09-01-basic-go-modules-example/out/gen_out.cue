package out

{
	Scenarios: [{
		Name:        "go115"
		Description: "Go 1.15"
	}]
	Networks: ["playwithgo_gitea"]
	Env: ["PLAYWITHGO_ROOTCA"]
	Presteps: [{
		Path:    "/newuser"
		Package: "github.com/play-with-go/gitea"
		Args: {
			Repos: [{
				Pattern: "mod1*"
				Var:     "REPO1"
			}]
		}
		Version: """
        {
          \"Path\": \"github.com/play-with-go/gitea/cmd/gitea\",
          \"Main\": {
            \"Path\": \"github.com/play-with-go/gitea\",
            \"Version\": \"v0.0.0-20200910060534-3b55d1ab0435\",
            \"Sum\": \"h1:gzLdttqUPoFy49mF1ZbJOYyU1K3hNPJTXC7nWsOMILg=\",
            \"Replace\": null
          },
          \"Deps\": [
            {
              \"Path\": \"code.gitea.io/sdk/gitea\",
              \"Version\": \"v0.12.1\",
              \"Sum\": \"h1:bMgjEqPnNX/i6TpVwXwpjJtFOnUSuC9P6yy/jjy8sjY=\",
              \"Replace\": null
            },
            {
              \"Path\": \"cuelang.org/go\",
              \"Version\": \"v0.2.2\",
              \"Sum\": \"h1:i/wFo48WDibGHKQTRZ08nB8PqmGpVpQ2sRflZPj73nQ=\",
              \"Replace\": null
            },
            {
              \"Path\": \"github.com/cockroachdb/apd/v2\",
              \"Version\": \"v2.0.1\",
              \"Sum\": \"h1:y1Rh3tEU89D+7Tgbw+lp52T6p/GJLpDmNvr10UWqLTE=\",
              \"Replace\": null
            },
            {
              \"Path\": \"github.com/emicklei/proto\",
              \"Version\": \"v1.6.15\",
              \"Sum\": \"h1:XbpwxmuOPrdES97FrSfpyy67SSCV/wBIKXqgJzh6hNw=\",
              \"Replace\": null
            },
            {
              \"Path\": \"github.com/google/go-github/v31\",
              \"Version\": \"v31.0.0\",
              \"Sum\": \"h1:JJUxlP9lFK+ziXKimTCprajMApV1ecWD4NB6CCb0plo=\",
              \"Replace\": null
            },
            {
              \"Path\": \"github.com/google/go-querystring\",
              \"Version\": \"v1.0.0\",
              \"Sum\": \"h1:Xkwi/a1rcvNg1PPYe5vI8GbeBY/jrVuDX5ASuANWTrk=\",
              \"Replace\": null
            },
            {
              \"Path\": \"github.com/hashicorp/go-version\",
              \"Version\": \"v1.2.0\",
              \"Sum\": \"h1:3vNe/fWF5CBgRIguda1meWhsZHy3m8gCJ5wx+dIzX/E=\",
              \"Replace\": null
            },
            {
              \"Path\": \"github.com/mpvl/unique\",
              \"Version\": \"v0.0.0-20150818121801-cbe035fff7de\",
              \"Sum\": \"h1:D5x39vF5KCwKQaw+OC9ZPiLVHXz3UFw2+psEX+gYcto=\",
              \"Replace\": null
            },
            {
              \"Path\": \"github.com/pkg/errors\",
              \"Version\": \"v0.8.1\",
              \"Sum\": \"h1:iURUrRGxPUNPdy5/HRSm+Yj6okJ6UtLINN0Q9M4+h3I=\",
              \"Replace\": null
            },
            {
              \"Path\": \"github.com/play-with-go/preguide\",
              \"Version\": \"v0.0.0-20200910055839-cabee9c6c8f3\",
              \"Sum\": \"h1:BMbWheaL+yYGfc6SlEClcYFx/4X/g0WGf3GzkDtr2Uc=\",
              \"Replace\": null
            },
            {
              \"Path\": \"golang.org/x/crypto\",
              \"Version\": \"v0.0.0-20191011191535-87dc89f01550\",
              \"Sum\": \"h1:ObdrDkeb4kJdCP557AjRjq69pTHfNouLtWZG7j9rPN8=\",
              \"Replace\": null
            },
            {
              \"Path\": \"golang.org/x/net\",
              \"Version\": \"v0.0.0-20200602114024-627f9648deb9\",
              \"Sum\": \"h1:pNX+40auqi2JqRfOP1akLGtYcn15TUbkhwuCO3foqqM=\",
              \"Replace\": null
            },
            {
              \"Path\": \"golang.org/x/text\",
              \"Version\": \"v0.3.2\",
              \"Sum\": \"h1:tW2bmiBqwgJj/UpqtC8EpXEZVYOwU0yG4iWbprSVAcs=\",
              \"Replace\": null
            },
            {
              \"Path\": \"golang.org/x/xerrors\",
              \"Version\": \"v0.0.0-20191204190536-9bdfabe68543\",
              \"Sum\": \"h1:E7g+9GITq07hpfrRu66IVDexMakfv52eLZ2CXBWiKr4=\",
              \"Replace\": null
            },
            {
              \"Path\": \"gopkg.in/retry.v1\",
              \"Version\": \"v1.0.3\",
              \"Sum\": \"h1:a9CArYczAVv6Qs6VGoLMio99GEs7kY9UzSF9+LD+iGs=\",
              \"Replace\": null
            },
            {
              \"Path\": \"gopkg.in/yaml.v3\",
              \"Version\": \"v3.0.0-20200121175148-a6ecf24a6d71\",
              \"Sum\": \"h1:Xe2gvTZUJpsvOWUnvmL/tmhVBZUmHSvLbMjRj6NUUKo=\",
              \"Replace\": null
            }
          ]
        }
        """
		Variables: ["GITEA_USERNAME", "GITEA_PASSWORD", "REPO1"]
	}]
	Delims: ["{{", "}}"]
	Terminals: [{
		Name:        "term1"
		Description: "The main terminal"
		Scenarios: {
			go115: {
				Image: "playwithgo/go1.15.1@sha256:009b09b0b12874cb1dd362bc2471e39d430f6c2c7cac47dc9db2ab7a4290e59b"
			}
		}
	}]
	Langs: {
		en: {
			Steps: {
				create_module: {
					Name:     "create_module"
					StepType: 1
					Terminal: "term1"
					Order:    0
					Stmts: [{
						Negated:  false
						CmdStr:   "mkdir /home/gopher/mod1"
						ExitCode: 0
						Output:   ""
					}, {
						Negated:  false
						CmdStr:   "cd /home/gopher/mod1"
						ExitCode: 0
						Output:   ""
					}, {
						Negated:  false
						CmdStr:   "git init"
						ExitCode: 0
						Output: """
        Initialized empty Git repository in /home/gopher/mod1/.git/
        
        """
					}, {
						Negated:  false
						CmdStr:   "git remote add origin https://play-with-go.dev/userguides/{{.REPO1}}.git"
						ExitCode: 0
						Output:   ""
					}, {
						Negated:  false
						CmdStr:   "go mod init play-with-go.dev/userguides/{{.REPO1}}"
						ExitCode: 0
						Output: """
        go: creating new go.mod: module play-with-go.dev/userguides/{{.REPO1}}
        
        """
					}]
				}
				create_readme: {
					Name:     "create_readme"
					StepType: 2
					Terminal: "term1"
					Target:   "/home/gopher/mod1/README.md"
					Language: "md"
					Renderer: {
						RendererType: 1
					}
					Source: "## `play-with-go.dev/userguides/{{.REPO1}}`"
					Order:  1
				}
				create_main: {
					Name:     "create_main"
					StepType: 2
					Terminal: "term1"
					Target:   "/home/gopher/mod1/main.go"
					Language: "go"
					Renderer: {
						RendererType: 1
					}
					Source: """
        package main
        
        import \"fmt\"
        
        func main() {
        \tfmt.Println(\"Hello, world!\")
        }
        """
					Order: 2
				}
				commit_and_push: {
					Name:     "commit_and_push"
					StepType: 1
					Terminal: "term1"
					Order:    3
					Stmts: [{
						Negated:  false
						CmdStr:   "git add -A"
						ExitCode: 0
						Output:   ""
					}, {
						Negated:  false
						CmdStr:   "git commit -m \"Initial commit\""
						ExitCode: 0
						Output: """
        [main (root-commit) abcd123] Initial commit
         3 files changed, 11 insertions(+)
         create mode 100644 README.md
         create mode 100644 go.mod
         create mode 100644 main.go
        
        """
					}, {
						Negated:  false
						CmdStr:   "git push -u origin main"
						ExitCode: 0
						Output: """
        remote: . Processing 1 references        
        remote: Processed 1 references in total        
        To https://play-with-go.dev/userguides/{{.REPO1}}.git
         * [new branch]      main -> main
        Branch 'main' set up to track remote branch 'main' from 'origin'.
        
        """
					}]
				}
				use_module: {
					Name:     "use_module"
					StepType: 1
					Terminal: "term1"
					Order:    4
					Stmts: [{
						Negated:  false
						CmdStr:   "mkdir /home/gopher/mod2"
						ExitCode: 0
						Output:   ""
					}, {
						Negated:  false
						CmdStr:   "cd /home/gopher/mod2"
						ExitCode: 0
						Output:   ""
					}, {
						Negated:  false
						CmdStr:   "go mod init mod.com"
						ExitCode: 0
						Output: """
        go: creating new go.mod: module mod.com
        
        """
					}, {
						Negated:  false
						CmdStr:   "go get play-with-go.dev/userguides/{{.REPO1}}"
						ExitCode: 0
						Output: """
        go: downloading play-with-go.dev/userguides/{{.REPO1}} v0.0.0-20060102150405-abcde12345
        go: play-with-go.dev/userguides/{{.REPO1}} upgrade => v0.0.0-20060102150405-abcde12345
        
        """
					}, {
						Negated:  false
						CmdStr:   "go run play-with-go.dev/userguides/{{.REPO1}}"
						ExitCode: 0
						Output: """
        Hello, world!
        
        """
					}]
				}
			}
			Hash: "1dd15a2b13fc289d88730783c8944bd35d55e1bf15fb400ad319066db3f347d2"
		}
	}
}
