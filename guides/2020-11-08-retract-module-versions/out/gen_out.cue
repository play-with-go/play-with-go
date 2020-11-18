package out

Presteps: [{
	Variables: ["GITEA_USERNAME", "GITEA_PRIV_KEY", "GITEA_PUB_KEY", "GITEA_KEYSCAN", "PROVERB"]
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
		      "Version": "v0.3.0-alpha4.0.20201116194914-7463d11dea50",
		      "Sum": "h1:8FV7bhN9Nn6aq8Zkj/2nHefqGKoCbdRJ2g4NVovgZoE=",
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
		      "Version": "v0.0.2-0.20201118092925-fce461f5635f",
		      "Sum": "h1:zxijrOjGkwsssW3/huiVMjDKgFP193VK7oYIb8q+kiE=",
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
			Var:     "PROVERB"
			Private: false
			Pattern: "proverb"
		}]
	}
	Package: "github.com/play-with-go/gitea"
	Path:    "/newuser"
}]
Terminals: [{
	Description: "The main terminal"
	Scenarios: {
		go116: {
			Image: "playwithgo/go1.16-tip@sha256:32d8ed6e153b937670343af5132bc62ac2b6ac2eb5ba82adc761775897f33f16"
		}
	}
	Name: "term1"
}]
Scenarios: [{
	Description: "Go 1.16"
	Name:        "go116"
}]
Networks: ["playwithgo_pwg"]
Env: []
Steps: {
	gopher_run_life_proverb: {
		Stmts: [{
			ComparisonOutput: """
				Go proverb: Concurrency is not parallelism.
				Life advice: A bird in the hand is worth two in the bush.

				"""
			Output: """
				Go proverb: Concurrency is not parallelism.
				Life advice: A bird in the hand is worth two in the bush.

				"""
			ExitCode: 0
			CmdStr:   "go run ."
			Negated:  false
		}]
		Order:           43
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_run_life_proverb"
	}
	gopher_go_update_life_proverb: {
		Order: 42
		Source: """
			package main

			import (
			\t"fmt"

			\t"{{{.PROVERB}}}"
			)

			func main() {
			\tfmt.Printf("Go proverb: %v\\n", proverb.Go())
			\tfmt.Printf("Life advice: %v\\n", proverb.Life())
			}

			"""
		Renderer: {
			Pre: """
				package main

				import (
				\t"fmt"

				\t"{{{.PROVERB}}}"
				)

				func main() {
				\tfmt.Println(proverb.Go())
				}

				"""
			RendererType: 3
		}
		Language: "go"
		Target:   "/home/gopher/gopher/gopher.go"
		Terminal: "term1"
		StepType: 2
		Name:     "gopher_go_update_life_proverb"
	}
	gopher_list_proverb_v101_nonretracted: {
		Stmts: [{
			ComparisonOutput: """
				{{{.PROVERB}}} v0.1.0 v0.3.0 v0.4.0

				"""
			Output: """
				{{{.PROVERB}}} v0.1.0 v0.3.0 v0.4.0

				"""
			ExitCode: 0
			CmdStr:   "go list -m -versions {{{.PROVERB}}}"
			Negated:  false
		}]
		Order:           41
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_list_proverb_v101_nonretracted"
	}
	gopher_list_proverb_v101_retracted: {
		Stmts: [{
			ComparisonOutput: """
				{{{.PROVERB}}} v0.1.0 v0.2.0 v0.3.0 v0.4.0 v1.0.0 v1.0.1

				"""
			Output: """
				{{{.PROVERB}}} v0.1.0 v0.2.0 v0.3.0 v0.4.0 v1.0.0 v1.0.1

				"""
			ExitCode: 0
			CmdStr:   "go list -m -versions -retracted {{{.PROVERB}}}"
			Negated:  false
		}]
		Order:           40
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_list_proverb_v101_retracted"
	}
	gopher_sleep_on_proxy_again: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "sleep 1m"
			Negated:          false
		}]
		Order:           39
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_sleep_on_proxy_again"
	}
	gopher_use_v101: {
		Stmts: [{
			ComparisonOutput: """

				go: downloading {{{.PROVERB}}} v1.0.0
				go: run 'go get {{{.PROVERB}}}@latest' to switch to the latest unretracted version
				go: warning: {{{.PROVERB}}}@v1.0.0 is retracted: Published v1 too early
				"""
			Output: """
				go: downloading {{{.PROVERB}}} v1.0.0
				go: warning: {{{.PROVERB}}}@v1.0.0 is retracted: Published v1 too early
				go: run 'go get {{{.PROVERB}}}@latest' to switch to the latest unretracted version

				"""
			ExitCode: 0
			CmdStr:   "go get {{{.PROVERB}}}@v1.0.0"
			Negated:  false
		}, {
			ComparisonOutput: """

				go: downloading {{{.PROVERB}}} v1.0.1
				go: run 'go get {{{.PROVERB}}}@latest' to switch to the latest unretracted version
				go: warning: {{{.PROVERB}}}@v1.0.1 is retracted: Published v1 too early
				"""
			Output: """
				go: downloading {{{.PROVERB}}} v1.0.1
				go: warning: {{{.PROVERB}}}@v1.0.1 is retracted: Published v1 too early
				go: run 'go get {{{.PROVERB}}}@latest' to switch to the latest unretracted version

				"""
			ExitCode: 0
			CmdStr:   "go get {{{.PROVERB}}}@v1.0.1"
			Negated:  false
		}, {
			ComparisonOutput: """

				go: downloading {{{.PROVERB}}} v0.4.0
				"""
			Output: """
				go: downloading {{{.PROVERB}}} v0.4.0

				"""
			ExitCode: 0
			CmdStr:   "go get {{{.PROVERB}}}@v0.4.0"
			Negated:  false
		}]
		Order:           38
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_use_v101"
	}
	temp_get_v101: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "(cd $(mktemp -d); export GOPATH=$(mktemp -d); go mod init mod.com; go get -x {{{.PROVERB}}}@v0.4.0; go get -x {{{.PROVERB}}}@v1.0.0; go get -x {{{.PROVERB}}}@v1.0.1; sleep 1m) >/dev/null 2>&1"
			Negated:          false
		}]
		Order:           37
		InformationOnly: true
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "temp_get_v101"
	}
	gopher_cd_use_v100: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/gopher"
			Negated:          false
		}]
		Order:           36
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_cd_use_v100"
	}
	proverb_tag_v101: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git add -A"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git commit -q -m \"Retract [v1.0.0, v1.0.1]\""
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
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git tag v1.0.1"
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
			CmdStr:   "git push -q origin v1.0.1"
			Negated:  false
		}]
		Order:           35
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "proverb_tag_v101"
	}
	proverb_retract_v100: {
		Order: 34
		Source: """
			module {{{.PROVERB}}}

			go 1.16

			retract (
			\t// Go proverb was totally wrong
			\tv0.2.0

			\t// Published v1 too early
			\t[v1.0.0, v1.0.1]
			)

			"""
		Renderer: {
			Pre: """
				module {{{.PROVERB}}}

				go 1.16

				// Go proverb was totally wrong
				retract v0.2.0

				"""
			RendererType: 3
		}
		Language: "mod"
		Target:   "/home/gopher/proverb/go.mod"
		Terminal: "term1"
		StepType: 2
		Name:     "proverb_retract_v100"
	}
	proverb_tag_v040: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git tag v0.4.0"
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
			CmdStr:   "git push -q origin v0.4.0"
			Negated:  false
		}]
		Order:           33
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "proverb_tag_v040"
	}
	proverb_tag_v100: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git tag v1.0.0"
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
			CmdStr:   "git push -q origin v1.0.0"
			Negated:  false
		}]
		Order:           32
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "proverb_tag_v100"
	}
	proverb_life_commit: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git add -A"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git commit -q -m \"Add Life() proverb\""
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
		Order:           31
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "proverb_life_commit"
	}
	proverb_go_life_advice: {
		Order: 30
		Source: """
			package proverb

			// Go returns a Go proverb
			func Go() string {
			\treturn "Concurrency is not parallelism."
			}

			// Life returns a proverb useful for day-to-day living
			func Life() string {
			\treturn "A bird in the hand is worth two in the bush."
			}

			"""
		Renderer: {
			Pre: """
				package proverb

				// Go returns a Go proverb
				func Go() string {
				\treturn "Concurrency is not parallelism."
				}

				"""
			RendererType: 3
		}
		Language: "go"
		Target:   "/home/gopher/proverb/proverb.go"
		Terminal: "term1"
		StepType: 2
		Name:     "proverb_go_life_advice"
	}
	proverb_return_life: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/proverb"
			Negated:          false
		}]
		Order:           29
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "proverb_return_life"
	}
	gopher_use_latest_unretracted: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "go get {{{.PROVERB}}}@latest"
			Negated:          false
		}]
		Order:           28
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_use_latest_unretracted"
	}
	gopher_list_versions: {
		Stmts: [{
			ComparisonOutput: """
				gopher
				{{{.PROVERB}}} v0.2.0 (retracted) [v0.3.0]

				"""
			Output: """
				gopher
				{{{.PROVERB}}} v0.2.0 (retracted) [v0.3.0]

				"""
			ExitCode: 0
			CmdStr:   "go list -m -u all"
			Negated:  false
		}]
		Order:           27
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_list_versions"
	}
	gopher_run_retracted_v020: {
		Stmts: [{
			ComparisonOutput: """
				Concurrency is parallelism.

				"""
			Output: """
				Concurrency is parallelism.

				"""
			ExitCode: 0
			CmdStr:   "go run ."
			Negated:  false
		}]
		Order:           26
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_run_retracted_v020"
	}
	gopher_use_retracted_v020: {
		Stmts: [{
			ComparisonOutput: """

				go: run 'go get {{{.PROVERB}}}@latest' to switch to the latest unretracted version
				go: warning: {{{.PROVERB}}}@v0.2.0 is retracted: Go proverb was totally wrong
				"""
			Output: """
				go: warning: {{{.PROVERB}}}@v0.2.0 is retracted: Go proverb was totally wrong
				go: run 'go get {{{.PROVERB}}}@latest' to switch to the latest unretracted version

				"""
			ExitCode: 0
			CmdStr:   "go get {{{.PROVERB}}}@v0.2.0"
			Negated:  false
		}]
		Order:           25
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_use_retracted_v020"
	}
	gopher_list_proverb_retracted: {
		Stmts: [{
			ComparisonOutput: """
				{{{.PROVERB}}} v0.1.0 v0.2.0 v0.3.0

				"""
			Output: """
				{{{.PROVERB}}} v0.1.0 v0.2.0 v0.3.0

				"""
			ExitCode: 0
			CmdStr:   "go list -m -versions -retracted {{{.PROVERB}}}"
			Negated:  false
		}]
		Order:           24
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_list_proverb_retracted"
	}
	gopher_list_proverb: {
		Stmts: [{
			ComparisonOutput: """
				{{{.PROVERB}}} v0.1.0 v0.3.0

				"""
			Output: """
				{{{.PROVERB}}} v0.1.0 v0.3.0

				"""
			ExitCode: 0
			CmdStr:   "go list -m -versions {{{.PROVERB}}}"
			Negated:  false
		}]
		Order:           23
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_list_proverb"
	}
	gopher_sleep_on_proxy: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "sleep 1m"
			Negated:          false
		}]
		Order:           22
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_sleep_on_proxy"
	}
	gopher_run_v030: {
		Stmts: [{
			ComparisonOutput: """
				Concurrency is not parallelism.

				"""
			Output: """
				Concurrency is not parallelism.

				"""
			ExitCode: 0
			CmdStr:   "go run ."
			Negated:  false
		}]
		Order:           21
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_run_v030"
	}
	gopher_use_v030: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/gopher"
			Negated:          false
		}, {
			ComparisonOutput: """

				go: downloading {{{.PROVERB}}} v0.3.0
				"""
			Output: """
				go: downloading {{{.PROVERB}}} v0.3.0

				"""
			ExitCode: 0
			CmdStr:   "go get {{{.PROVERB}}}@v0.3.0"
			Negated:  false
		}]
		Order:           20
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_use_v030"
	}
	proverb_tag_v030: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git add -A"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git commit -q -m \"Fix severe error in Go proverb\""
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
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git tag v0.3.0"
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
			CmdStr:   "git push -q origin v0.3.0"
			Negated:  false
		}]
		Order:           19
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "proverb_tag_v030"
	}
	proverb_go_fix_concurrency_bug: {
		Order: 18
		Source: """
			package proverb

			// Go returns a Go proverb
			func Go() string {
			\treturn "Concurrency is not parallelism."
			}

			"""
		Renderer: {
			Pre: """
				package proverb

				// Go returns a Go proverb
				func Go() string {
				\treturn "Concurrency is parallelism."
				}

				"""
			RendererType: 3
		}
		Language: "go"
		Target:   "/home/gopher/proverb/proverb.go"
		Terminal: "term1"
		StepType: 2
		Name:     "proverb_go_fix_concurrency_bug"
	}
	proverb_comment_retraction: {
		Order: 17
		Source: """
			module {{{.PROVERB}}}

			go 1.16

			// Go proverb was totally wrong
			retract v0.2.0

			"""
		Renderer: {
			RendererType: 1
		}
		Language: "mod"
		Target:   "/home/gopher/proverb/go.mod"
		Terminal: "term1"
		StepType: 2
		Name:     "proverb_comment_retraction"
	}
	proverb_cat_v020_retract: {
		Stmts: [{
			ComparisonOutput: """
				module {{{.PROVERB}}}

				go 1.16

				retract v0.2.0

				"""
			Output: """
				module {{{.PROVERB}}}

				go 1.16

				retract v0.2.0

				"""
			ExitCode: 0
			CmdStr:   "cat go.mod"
			Negated:  false
		}]
		Order:           16
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "proverb_cat_v020_retract"
	}
	proverb_retract_v020: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "go mod edit -retract=v0.2.0"
			Negated:          false
		}]
		Order:           15
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "proverb_retract_v020"
	}
	proverb_return_to_retract_v020: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/proverb"
			Negated:          false
		}]
		Order:           14
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "proverb_return_to_retract_v020"
	}
	gopher_use_v020: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/gopher"
			Negated:          false
		}, {
			ComparisonOutput: """

				go: downloading {{{.PROVERB}}} v0.2.0
				"""
			Output: """
				go: downloading {{{.PROVERB}}} v0.2.0

				"""
			ExitCode: 0
			CmdStr:   "go get {{{.PROVERB}}}@v0.2.0"
			Negated:  false
		}, {
			ComparisonOutput: """
				Concurrency is parallelism.

				"""
			Output: """
				Concurrency is parallelism.

				"""
			ExitCode: 0
			CmdStr:   "go run ."
			Negated:  false
		}]
		Order:           13
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_use_v020"
	}
	proverb_tag_v020: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git tag v0.2.0"
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
			CmdStr:   "git push -q origin v0.2.0"
			Negated:  false
		}]
		Order:           12
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "proverb_tag_v020"
	}
	proverb_concurrency_commit: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git add -A"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git commit -q -m \"Switch Go proverb to something more famous\""
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
		Order:           11
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "proverb_concurrency_commit"
	}
	proverb_go_concurrency: {
		Order: 10
		Source: """
			package proverb

			// Go returns a Go proverb
			func Go() string {
			\treturn "Concurrency is parallelism."
			}

			"""
		Renderer: {
			Pre: """
				package proverb

				// Go returns a Go proverb
				func Go() string {
				\treturn "Don't communicate by sharing memory, share memory by communicating."
				}

				"""
			RendererType: 3
		}
		Language: "go"
		Target:   "/home/gopher/proverb/proverb.go"
		Terminal: "term1"
		StepType: 2
		Name:     "proverb_go_concurrency"
	}
	proverb_cd_concurrency_change: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/proverb"
			Negated:          false
		}]
		Order:           9
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "proverb_cd_concurrency_change"
	}
	gopher_run_initial: {
		Stmts: [{
			ComparisonOutput: """
				Don't communicate by sharing memory, share memory by communicating.

				"""
			Output: """
				Don't communicate by sharing memory, share memory by communicating.

				"""
			ExitCode: 0
			CmdStr:   "go run ."
			Negated:  false
		}]
		Order:           8
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_run_initial"
	}
	gopher_add_dep_proverb_v010: {
		Stmts: [{
			ComparisonOutput: """

				go: downloading {{{.PROVERB}}} v0.1.0
				"""
			Output: """
				go: downloading {{{.PROVERB}}} v0.1.0

				"""
			ExitCode: 0
			CmdStr:   "go get {{{.PROVERB}}}@v0.1.0"
			Negated:  false
		}]
		Order:           7
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_add_dep_proverb_v010"
	}
	gopher_go_initial: {
		Order: 6
		Source: """
			package main

			import (
			\t"fmt"

			\t"{{{.PROVERB}}}"
			)

			func main() {
			\tfmt.Println(proverb.Go())
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
	gopher_create: {
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
		Order:           5
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gopher_create"
	}
	proverb_tag_v010: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git tag v0.1.0"
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
			CmdStr:   "git push -q origin v0.1.0"
			Negated:  false
		}]
		Order:           4
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "proverb_tag_v010"
	}
	proverb_initial_commit: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git add -A"
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
		Name:            "proverb_initial_commit"
	}
	proverb_go_initial: {
		Order: 2
		Source: """
			package proverb

			// Go returns a Go proverb
			func Go() string {
			\treturn "Don't communicate by sharing memory, share memory by communicating."
			}

			"""
		Renderer: {
			RendererType: 1
		}
		Language: "go"
		Target:   "/home/gopher/proverb/proverb.go"
		Terminal: "term1"
		StepType: 2
		Name:     "proverb_go_initial"
	}
	proverb_create: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "mkdir /home/gopher/proverb"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/proverb"
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
			CmdStr:           "git remote add origin https://{{{.PROVERB}}}.git"
			Negated:          false
		}, {
			ComparisonOutput: """
				go: creating new go.mod: module {{{.PROVERB}}}

				"""
			Output: """
				go: creating new go.mod: module {{{.PROVERB}}}

				"""
			ExitCode: 0
			CmdStr:   "go mod init {{{.PROVERB}}}"
			Negated:  false
		}]
		Order:           1
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "proverb_create"
	}
	goversion: {
		Stmts: [{
			ComparisonOutput: """
				go version devel +7307e86afd Sun Nov 8 12:19:55 2020 +0000 linux/amd64

				"""
			Output: """
				go version devel +7307e86afd Sun Nov 8 12:19:55 2020 +0000 linux/amd64

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
Hash: "4903be7ac3be0c9257f1fb1dde15d5fd9d7879dea3acce29b3db73d16db81c9b"
Delims: ["{{{", "}}}"]
