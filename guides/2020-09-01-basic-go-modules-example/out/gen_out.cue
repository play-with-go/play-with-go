package out

Presteps: [{
	Variables: ["GITEA_USERNAME", "GITEA_PASSWORD", "REPO1"]
	Version: """
        {
          \"Path\": \"github.com/play-with-go/gitea/cmd/gitea\",
          \"Main\": {
            \"Path\": \"github.com/play-with-go/gitea\",
            \"Version\": \"v0.0.0-20200921114606-e713515083fc\",
            \"Sum\": \"h1:LxgPteEy6dGKY60JxW6dFZhsDEJA0d2xlft0hsF+1AA=\",
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
              \"Version\": \"v0.3.0-alpha3\",
              \"Sum\": \"h1:CxqJByVB1t6kcgcVnBYfcxWmzcupeepnoaI1CKaOC7U=\",
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
              \"Version\": \"v0.0.0-20200921113921-e25b36230915\",
              \"Sum\": \"h1:Wpe48q8eGdQugB3tG2USVASQKFMopSFPY4MoYtFIyMM=\",
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
			Image: "playwithgo/go1.15.1@sha256:009b09b0b12874cb1dd362bc2471e39d430f6c2c7cac47dc9db2ab7a4290e59b"
		}
	}
	Name: "term1"
}]
Scenarios: [{
	Description: "Go 1.15"
	Name:        "go115"
}]
Networks: ["playwithgo_gitea"]
Env: ["PLAYWITHGO_ROOTCA"]
Langs: {
	en: {
		Hash: "67d0ae3f341e6e85fcb59dd860cf1db4df7c130c78261ec3eb0625ee7600ca6e"
		Steps: {
			use_module: {
				Stmts: [{
					Output:   ""
					ExitCode: 0
					CmdStr:   "mkdir /home/gopher/mod2"
					Negated:  false
				}, {
					Output:   ""
					ExitCode: 0
					CmdStr:   "cd /home/gopher/mod2"
					Negated:  false
				}, {
					Output: """
        go: creating new go.mod: module mod.com
        
        """
					ExitCode: 0
					CmdStr:   "go mod init mod.com"
					Negated:  false
				}, {
					Output: """
        go: downloading play-with-go.dev/userguides/{{{.REPO1}}} v0.0.0-20060102150405-abcde12345
        go: play-with-go.dev/userguides/{{{.REPO1}}} upgrade => v0.0.0-20060102150405-abcde12345
        
        """
					ExitCode: 0
					CmdStr:   "go get play-with-go.dev/userguides/{{{.REPO1}}}"
					Negated:  false
				}, {
					Output: """
        Hello, world!
        
        """
					ExitCode: 0
					CmdStr:   "go run play-with-go.dev/userguides/{{{.REPO1}}}"
					Negated:  false
				}]
				Order:    4
				Terminal: "term1"
				StepType: 1
				Name:     "use_module"
			}
			commit_and_push: {
				Stmts: [{
					Output:   ""
					ExitCode: 0
					CmdStr:   "git add -A"
					Negated:  false
				}, {
					Output: """
        [main (root-commit) abcd123] Initial commit
         3 files changed, 11 insertions(+)
         create mode 100644 README.md
         create mode 100644 go.mod
         create mode 100644 main.go
        
        """
					ExitCode: 0
					CmdStr:   "git commit -m \"Initial commit\""
					Negated:  false
				}, {
					Output: """
        remote: . Processing 1 references        
        remote: Processed 1 references in total        
        To https://play-with-go.dev/userguides/{{{.REPO1}}}.git
         * [new branch]      main -> main
        Branch 'main' set up to track remote branch 'main' from 'origin'.
        
        """
					ExitCode: 0
					CmdStr:   "git push -u origin main"
					Negated:  false
				}]
				Order:    3
				Terminal: "term1"
				StepType: 1
				Name:     "commit_and_push"
			}
			create_main: {
				Order: 2
				Source: """
        package main
        
        import \"fmt\"
        
        func main() {
        \tfmt.Println(\"Hello, world!\")
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
			create_readme: {
				Order:  1
				Source: "## `play-with-go.dev/userguides/{{{.REPO1}}}`"
				Renderer: {
					RendererType: 1
				}
				Language: "md"
				Target:   "/home/gopher/mod1/README.md"
				Terminal: "term1"
				StepType: 2
				Name:     "create_readme"
			}
			create_module: {
				Stmts: [{
					Output:   ""
					ExitCode: 0
					CmdStr:   "mkdir /home/gopher/mod1"
					Negated:  false
				}, {
					Output:   ""
					ExitCode: 0
					CmdStr:   "cd /home/gopher/mod1"
					Negated:  false
				}, {
					Output: """
        Initialized empty Git repository in /home/gopher/mod1/.git/
        
        """
					ExitCode: 0
					CmdStr:   "git init"
					Negated:  false
				}, {
					Output:   ""
					ExitCode: 0
					CmdStr:   "git remote add origin https://play-with-go.dev/userguides/{{{.REPO1}}}.git"
					Negated:  false
				}, {
					Output: """
        go: creating new go.mod: module play-with-go.dev/userguides/{{{.REPO1}}}
        
        """
					ExitCode: 0
					CmdStr:   "go mod init play-with-go.dev/userguides/{{{.REPO1}}}"
					Negated:  false
				}]
				Order:    0
				Terminal: "term1"
				StepType: 1
				Name:     "create_module"
			}
		}
	}
}
Delims: ["{{{", "}}}"]
