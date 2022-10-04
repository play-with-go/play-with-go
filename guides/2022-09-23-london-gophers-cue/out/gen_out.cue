package out

Terminals: [{
	Name:        "term1"
	Description: "The main terminal"
	Scenarios: {
		go119: {
			Image: "playwithgo/cue_v0.4.3_go1.19.1:6d8215b3a5eda6d3bcf338c58a26194abe18b4cd"
		}
	}
}]
Scenarios: [{
	Name:        "go119"
	Description: "cue v0.4.3 Go 1.19"
}]
Networks: ["playwithgo_pwg"]
Env: []
Steps: {
	cachesetup: {
		StepType:        1
		InformationOnly: true
		Name:            "cachesetup"
		Order:           0
		Terminal:        "term1"
		Stmts: [{
			CmdStr:   "sudo mkdir -p /var/gocache /var/gomodcache"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "sudo chown gopher:gopher /var/gocache /var/gomodcache"
			ExitCode: 0
			Output:   ""
		}]
	}
	versions: {
		StepType: 1
		Name:     "versions"
		Order:    1
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go version"
			ExitCode: 0
			Output: """
				go version go1.19.1 linux/amd64

				"""
		}, {
			CmdStr:   "cue version"
			ExitCode: 0
			Output: """
				cue version v0.4.4-0.20220923112746-fe50dff0dce8

				       -compiler gc
				     CGO_ENABLED 1
				          GOARCH amd64
				            GOOS linux

				"""
		}]
	}
	startexample: {
		StepType: 1
		Name:     "startexample"
		Order:    2
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "mkdir demo"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "cd demo"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "go mod init example.com/demo"
			ExitCode: 0
			Output: """
				go: creating new go.mod: module example.com/demo

				"""
		}]
	}
	create_initialmain: {
		StepType: 2
		Name:     "create_initialmain"
		Order:    3
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package main

			import (
			\t"encoding/json"
			\t"fmt"
			\t"log"
			\t"os"
			\t"path/filepath"
			)

			type Config struct {
			\tPrograms map[string]Program `json:"programs"`
			}

			type Program struct {
			\tPath         string   `json:"path"`
			\tArgs         []string `json:"args"`
			\tDescription  string   `json:"description"`
			\tRetries      int      `json:"retries"`
			\tIgnoreErrors bool     `json:"ignoreErrors"`
			\tDirectory    string   `json:"directory"`
			}

			func main() {
			\t// Use a fake "$HOME" for the purposes of this demo
			\tcfpath := filepath.Join("home", ".config", "demo", "config.json")

			\tcf, err := os.ReadFile(cfpath)
			\tif err != nil {
			\t\tlog.Fatal(err)
			\t}

			\tvar conf Config
			\tif err := json.Unmarshal(cf, &conf); err != nil {
			\t\tlog.Fatal(err)
			\t}

			\tout, err := json.MarshalIndent(conf, "", "  ")
			\tif err != nil {
			\t\tlog.Fatal(err)
			\t}
			\tfmt.Printf("%s\\n", out)
			}

			"""
		Target: "/home/gopher/demo/main.go"
	}
	create_config_dir: {
		StepType: 1
		Name:     "create_config_dir"
		Order:    4
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "mkdir -p /home/gopher/demo/home/.config/demo"
			ExitCode: 0
			Output:   ""
		}]
	}
	initial_config_file: {
		StepType: 2
		Name:     "initial_config_file"
		Order:    5
		Terminal: "term1"
		Language: "json"
		Renderer: {
			RendererType: 1
		}
		Source: """
			{
			\t "programs": {
			\t\t  "service1": {
			\t\t\t\t"path": "/path/to/service1",
			\t\t\t\t"description": "service1 is a special service\\nfor special things",
			\t\t\t\t"args": [
			\t\t\t\t\t "hello",
			\t\t\t\t\t "world"
			\t\t\t\t],
			\t\t\t\t"directory": "/tmp",
			\t\t\t\t"ignoreErrors": true
			\t\t  },
			\t\t  "service2": {
			\t\t\t\t"path": "/path/to/service2",
			\t\t\t\t"description": "service2 is a special service\\nfor special things",
			\t\t\t\t"args": [
			\t\t\t\t\t "hello",
			\t\t\t\t\t "world"
			\t\t\t\t],
			\t\t\t\t"directory": "/home/cueckoo"
			\t\t  },
			\t\t  "service3": {
			\t\t\t\t"path": "/path/to/service3",
			\t\t\t\t"description": "service3 is a special service\\nfor special things",
			\t\t\t\t"directory": "/home/cueckoo"
			\t\t  }
			\t }
			}
			"""
		Target: "/home/gopher/demo/home/.config/demo/config.json"
	}
	run_v_json: {
		StepType: 1
		Name:     "run_v_json"
		Order:    6
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "cat go.mod"
			ExitCode: 0
			Output: """
				module example.com/demo

				go 1.19

				"""
		}, {
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				{
				  "programs": {
				    "service1": {
				      "path": "/path/to/service1",
				      "args": [
				        "hello",
				        "world"
				      ],
				      "description": "service1 is a special service\\nfor special things",
				      "retries": 0,
				      "ignoreErrors": true,
				      "directory": "/tmp"
				    },
				    "service2": {
				      "path": "/path/to/service2",
				      "args": [
				        "hello",
				        "world"
				      ],
				      "description": "service2 is a special service\\nfor special things",
				      "retries": 0,
				      "ignoreErrors": false,
				      "directory": "/home/cueckoo"
				    },
				    "service3": {
				      "path": "/path/to/service3",
				      "args": null,
				      "description": "service3 is a special service\\nfor special things",
				      "retries": 0,
				      "ignoreErrors": false,
				      "directory": "/home/cueckoo"
				    }
				  }
				}

				"""
		}]
	}
	import_json_cue: {
		StepType: 1
		Name:     "import_json_cue"
		Order:    7
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "cue import ./home/.config/demo/config.json"
			ExitCode: 0
			Output:   ""
		}]
	}
	inspect_initial_cue: {
		StepType: 1
		Name:     "inspect_initial_cue"
		Order:    8
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "cat ./home/.config/demo/config.cue"
			ExitCode: 0
			Output: #"""
				programs: {
				\#tservice1: {
				\#t\#tpath: "/path/to/service1"
				\#t\#tdescription: """
				\#t\#t\#tservice1 is a special service
				\#t\#t\#tfor special things
				\#t\#t\#t"""
				\#t\#targs: [
				\#t\#t\#t"hello",
				\#t\#t\#t"world",
				\#t\#t]
				\#t\#tdirectory:    "/tmp"
				\#t\#tignoreErrors: true
				\#t}
				\#tservice2: {
				\#t\#tpath: "/path/to/service2"
				\#t\#tdescription: """
				\#t\#t\#tservice2 is a special service
				\#t\#t\#tfor special things
				\#t\#t\#t"""
				\#t\#targs: [
				\#t\#t\#t"hello",
				\#t\#t\#t"world",
				\#t\#t]
				\#t\#tdirectory: "/home/cueckoo"
				\#t}
				\#tservice3: {
				\#t\#tpath: "/path/to/service3"
				\#t\#tdescription: """
				\#t\#t\#tservice3 is a special service
				\#t\#t\#tfor special things
				\#t\#t\#t"""
				\#t\#tdirectory: "/home/cueckoo"
				\#t}
				}

				"""#
		}]
	}
	export_json: {
		StepType: 1
		Name:     "export_json"
		Order:    9
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "cue export ./home/.config/demo/config.cue"
			ExitCode: 0
			Output: """
				{
				    "programs": {
				        "service1": {
				            "path": "/path/to/service1",
				            "description": "service1 is a special service\\nfor special things",
				            "args": [
				                "hello",
				                "world"
				            ],
				            "directory": "/tmp",
				            "ignoreErrors": true
				        },
				        "service2": {
				            "path": "/path/to/service2",
				            "description": "service2 is a special service\\nfor special things",
				            "args": [
				                "hello",
				                "world"
				            ],
				            "directory": "/home/cueckoo"
				        },
				        "service3": {
				            "path": "/path/to/service3",
				            "description": "service3 is a special service\\nfor special things",
				            "directory": "/home/cueckoo"
				        }
				    }
				}

				"""
		}]
	}
	export_json_diff: {
		StepType: 1
		Name:     "export_json_diff"
		Order:    10
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "mv ./home/.config/demo/config.json ./home/.config/demo/config.json.copy"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "cue export -o ./home/.config/demo/config.json ./home/.config/demo/config.cue"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "diff -wu ./home/.config/demo/config.json ./home/.config/demo/config.json.copy"
			ExitCode: 0
			Output:   ""
		}]
	}
	initial_main_cueconfig: {
		StepType: 2
		Name:     "initial_main_cueconfig"
		Order:    11
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package main

			import (
			\t"encoding/json"
			\t"fmt"
			\t"log"
			\t"path/filepath"

			\t"github.com/cue-exp/cueconfig"
			)

			type Config struct {
			\tPrograms map[string]Program `json:"programs"`
			}

			type Program struct {
			\tPath         string   `json:"path"`
			\tArgs         []string `json:"args"`
			\tDescription  string   `json:"description"`
			\tRetries      int      `json:"retries"`
			\tIgnoreErrors bool     `json:"ignoreErrors"`
			\tDirectory    string   `json:"directory"`
			}

			func main() {
			\t// Use a fake "$HOME" for the purposes of this demo
			\tcfpath := filepath.Join("home", ".config", "demo", "config.cue")

			\tvar conf Config
			\tif err := cueconfig.Load(cfpath, nil, nil, nil, &conf); err != nil {
			\t\tlog.Fatal(err)
			\t}

			\tout, err := json.MarshalIndent(conf, "", "  ")
			\tif err != nil {
			\t\tlog.Fatal(err)
			\t}
			\tfmt.Printf("%s\\n", out)
			}

			"""
		Target: "/home/gopher/demo/main.go"
	}
	get_cueconfig_and_tidy: {
		StepType: 1
		Name:     "get_cueconfig_and_tidy"
		Order:    12
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go get github.com/cue-exp/cueconfig@v0.0.1"
			ExitCode: 0
			Output: """
				go: downloading github.com/cue-exp/cueconfig v0.0.1
				go: downloading cuelang.org/go v0.4.3
				go: downloading github.com/cockroachdb/apd/v2 v2.0.1
				go: downloading golang.org/x/net v0.0.0-20200226121028-0de0cce0169b
				go: downloading github.com/emicklei/proto v1.6.15
				go: downloading github.com/protocolbuffers/txtpbfmt v0.0.0-20201118171849-f6a6b3f636fc
				go: downloading gopkg.in/yaml.v3 v3.0.0-20210107192922-496545a6307b
				go: added cuelang.org/go v0.4.3
				go: added github.com/cockroachdb/apd/v2 v2.0.1
				go: added github.com/cue-exp/cueconfig v0.0.1
				go: added github.com/emicklei/proto v1.6.15
				go: added github.com/golang/glog v0.0.0-20160126235308-23def4e6c14b
				go: added github.com/google/uuid v1.2.0
				go: added github.com/mpvl/unique v0.0.0-20150818121801-cbe035fff7de
				go: added github.com/pkg/errors v0.8.1
				go: added github.com/protocolbuffers/txtpbfmt v0.0.0-20201118171849-f6a6b3f636fc
				go: added golang.org/x/net v0.0.0-20200226121028-0de0cce0169b
				go: added golang.org/x/text v0.3.7
				go: added gopkg.in/yaml.v3 v3.0.0-20210107192922-496545a6307b

				"""
		}, {
			CmdStr:   "go mod tidy"
			ExitCode: 0
			Output: """
				go: downloading github.com/rogpeppe/go-internal v1.9.0
				go: downloading github.com/google/go-cmp v0.4.0
				go: downloading github.com/stretchr/testify v1.2.2
				go: downloading github.com/kylelemons/godebug v1.1.0
				go: downloading github.com/pkg/diff v0.0.0-20210226163009-20ebb0f2a09e
				go: downloading github.com/cockroachdb/apd v1.1.0
				go: downloading github.com/lib/pq v1.0.0
				go: downloading github.com/davecgh/go-spew v1.1.1
				go: downloading github.com/pmezard/go-difflib v1.0.0
				go: downloading golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543
				go: downloading github.com/kr/pretty v0.1.0
				go: downloading golang.org/x/tools v0.0.0-20200612220849-54c614fe050c
				go: downloading github.com/kr/text v0.1.0
				go: downloading gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405

				"""
		}]
	}
	run_initial_cueconfig: {
		StepType: 1
		Name:     "run_initial_cueconfig"
		Order:    13
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				{
				  "programs": {
				    "service1": {
				      "path": "/path/to/service1",
				      "args": [
				        "hello",
				        "world"
				      ],
				      "description": "service1 is a special service\\nfor special things",
				      "retries": 0,
				      "ignoreErrors": true,
				      "directory": "/tmp"
				    },
				    "service2": {
				      "path": "/path/to/service2",
				      "args": [
				        "hello",
				        "world"
				      ],
				      "description": "service2 is a special service\\nfor special things",
				      "retries": 0,
				      "ignoreErrors": false,
				      "directory": "/home/cueckoo"
				    },
				    "service3": {
				      "path": "/path/to/service3",
				      "args": null,
				      "description": "service3 is a special service\\nfor special things",
				      "retries": 0,
				      "ignoreErrors": false,
				      "directory": "/home/cueckoo"
				    }
				  }
				}

				"""
		}]
	}
	create_initial_schema: {
		StepType: 2
		Name:     "create_initial_schema"
		Order:    14
		Terminal: "term1"
		Language: "cue"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package main

			programs: [string]: #Program

			#Program: {
			\tpath: string
			\targs?: [...string]
			\tdescription:   string
			\tretries?:      int
			\tignoreErrors?: bool
			\tdirectory?:    string
			}

			"""
		Target: "/home/gopher/demo/schema.cue"
	}
	update_main_schema: {
		StepType: 2
		Name:     "update_main_schema"
		Order:    15
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package main

			import (
			\t_ "embed"
			\t"encoding/json"
			\t"fmt"
			\t"log"
			\t"path/filepath"

			\t"github.com/cue-exp/cueconfig"
			)

			type Config struct {
			\tPrograms map[string]Program `json:"programs"`
			}

			type Program struct {
			\tPath         string   `json:"path"`
			\tArgs         []string `json:"args"`
			\tDescription  string   `json:"description"`
			\tRetries      int      `json:"retries"`
			\tIgnoreErrors bool     `json:"ignoreErrors"`
			\tDirectory    string   `json:"directory"`
			}

			var (
			\t//go:embed schema.cue
			\tschema []byte
			)

			func main() {
			\t// Use a fake "$HOME" for the purposes of this demo
			\tcfpath := filepath.Join("home", ".config", "demo", "config.cue")

			\tvar conf Config
			\tif err := cueconfig.Load(cfpath, schema, nil, nil, &conf); err != nil {
			\t\tlog.Fatal(err)
			\t}

			\tout, err := json.MarshalIndent(conf, "", "  ")
			\tif err != nil {
			\t\tlog.Fatal(err)
			\t}
			\tfmt.Printf("%s\\n", out)
			}

			"""
		Target: "/home/gopher/demo/main.go"
	}
	run_initial_schema: {
		StepType: 1
		Name:     "run_initial_schema"
		Order:    16
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				{
				  "programs": {
				    "service1": {
				      "path": "/path/to/service1",
				      "args": [
				        "hello",
				        "world"
				      ],
				      "description": "service1 is a special service\\nfor special things",
				      "retries": 0,
				      "ignoreErrors": true,
				      "directory": "/tmp"
				    },
				    "service2": {
				      "path": "/path/to/service2",
				      "args": [
				        "hello",
				        "world"
				      ],
				      "description": "service2 is a special service\\nfor special things",
				      "retries": 0,
				      "ignoreErrors": false,
				      "directory": "/home/cueckoo"
				    },
				    "service3": {
				      "path": "/path/to/service3",
				      "args": null,
				      "description": "service3 is a special service\\nfor special things",
				      "retries": 0,
				      "ignoreErrors": false,
				      "directory": "/home/cueckoo"
				    }
				  }
				}

				"""
		}]
	}
	break_config_additional_field: {
		StepType: 2
		Name:     "break_config_additional_field"
		Order:    17
		Terminal: "term1"
		Language: "cue"
		Renderer: {
			RendererType: 1
		}
		Source: #"""
			programs: {
			\#tservice1: {
			\#t\#tpath: "/path/to/service1"
			\#t\#tdescription: """
			\#t\#t\#tservice1 is a special service
			\#t\#t\#tfor special things
			\#t\#t\#t"""
			\#t\#targs: [
			\#t\#t\#t"hello",
			\#t\#t\#t"world",
			\#t\#t]
			\#t\#tdirectory:    "/tmp"
			\#t\#tignoreErrors: true
			\#t\#tblah:         "something"
			\#t}
			\#tservice2: {
			\#t\#tpath: "/path/to/service2"
			\#t\#tdescription: """
			\#t\#t\#tservice2 is a special service
			\#t\#t\#tfor special things
			\#t\#t\#t"""
			\#t\#targs: [
			\#t\#t\#t"hello",
			\#t\#t\#t"world",
			\#t\#t]
			\#t\#tdirectory: "/home/cueckoo"
			\#t}
			\#tservice3: {
			\#t\#tpath: "/path/to/service3"
			\#t\#tdescription: """
			\#t\#t\#tservice3 is a special service
			\#t\#t\#tfor special things
			\#t\#t\#t"""
			\#t\#tdirectory: "/home/cueckoo"
			\#t}
			}

			"""#
		Target: "/home/gopher/demo/home/.config/demo/config.cue"
	}
	run_broken_config_additional_field: {
		StepType: 1
		Name:     "run_broken_config_additional_field"
		Order:    18
		Terminal: "term1"
		Stmts: [{
			Negated:  true
			CmdStr:   "go run ."
			ExitCode: 1
			Output: """
				main.go:37: error in configuration: programs.service1: field not allowed: blah:
				    $schema.cue:3:21
				    $schema.cue:5:11
				    /home/gopher/demo/home/.config/demo/config.cue:14:3
				exit status 1

				"""
		}]
	}
	restore_config_working: {
		StepType: 2
		Name:     "restore_config_working"
		Order:    19
		Terminal: "term1"
		Language: "cue"
		Renderer: {
			RendererType: 1
		}
		Source: #"""
			programs: {
			\#tservice1: {
			\#t\#tpath: "/path/to/service1"
			\#t\#tdescription: """
			\#t\#t\#tservice1 is a special service
			\#t\#t\#tfor special things
			\#t\#t\#t"""
			\#t\#targs: [
			\#t\#t\#t"hello",
			\#t\#t\#t"world",
			\#t\#t]
			\#t\#tdirectory:    "/tmp"
			\#t\#tignoreErrors: true
			\#t}
			\#tservice2: {
			\#t\#tpath: "/path/to/service2"
			\#t\#tdescription: """
			\#t\#t\#tservice2 is a special service
			\#t\#t\#tfor special things
			\#t\#t\#t"""
			\#t\#targs: [
			\#t\#t\#t"hello",
			\#t\#t\#t"world",
			\#t\#t]
			\#t\#tdirectory: "/home/cueckoo"
			\#t}
			\#tservice3: {
			\#t\#tpath: "/path/to/service3"
			\#t\#tdescription: """
			\#t\#t\#tservice3 is a special service
			\#t\#t\#tfor special things
			\#t\#t\#t"""
			\#t\#tdirectory: "/home/cueckoo"
			\#t}
			}

			"""#
		Target: "/home/gopher/demo/home/.config/demo/config.cue"
	}
	run_check_config_working: {
		StepType: 1
		Name:     "run_check_config_working"
		Order:    20
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				{
				  "programs": {
				    "service1": {
				      "path": "/path/to/service1",
				      "args": [
				        "hello",
				        "world"
				      ],
				      "description": "service1 is a special service\\nfor special things",
				      "retries": 0,
				      "ignoreErrors": true,
				      "directory": "/tmp"
				    },
				    "service2": {
				      "path": "/path/to/service2",
				      "args": [
				        "hello",
				        "world"
				      ],
				      "description": "service2 is a special service\\nfor special things",
				      "retries": 0,
				      "ignoreErrors": false,
				      "directory": "/home/cueckoo"
				    },
				    "service3": {
				      "path": "/path/to/service3",
				      "args": null,
				      "description": "service3 is a special service\\nfor special things",
				      "retries": 0,
				      "ignoreErrors": false,
				      "directory": "/home/cueckoo"
				    }
				  }
				}

				"""
		}]
	}
	modify_config_dry: {
		StepType: 2
		Name:     "modify_config_dry"
		Order:    21
		Terminal: "term1"
		Language: "cue"
		Renderer: {
			RendererType: 1
		}
		Source: #"""
			import "strings"

			programs: [_name=string]: {
			\#tdirectory:   *"/home/cueckoo" | _
			\#tpath:        *"/path/to/\#\(_name)" | _
			\#tdescription: strings.HasPrefix(_name)
			}

			programs: {
			\#tservice1: {
			\#t\#tdescription: """
			\#t\#t\#tservice1 is a special service
			\#t\#t\#tfor special things
			\#t\#t\#t"""
			\#t\#targs: [
			\#t\#t\#t"hello",
			\#t\#t\#t"world",
			\#t\#t]
			\#t\#tdirectory:    "/tmp"
			\#t\#tignoreErrors: true
			\#t}
			\#tservice2: {
			\#t\#tdescription: """
			\#t\#t\#tservice2 is a special service
			\#t\#t\#tfor special things
			\#t\#t\#t"""
			\#t\#targs: service1.args,
			\#t}
			\#tservice3: {
			\#t\#tdescription: """
			\#t\#t\#tservice3 is a special service
			\#t\#t\#tfor special things
			\#t\#t\#t"""
			\#t}
			}

			"""#
		Target: "/home/gopher/demo/home/.config/demo/config.cue"
	}
	run_check_config_dry: {
		StepType: 1
		Name:     "run_check_config_dry"
		Order:    22
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				{
				  "programs": {
				    "service1": {
				      "path": "/path/to/service1",
				      "args": [
				        "hello",
				        "world"
				      ],
				      "description": "service1 is a special service\\nfor special things",
				      "retries": 0,
				      "ignoreErrors": true,
				      "directory": "/tmp"
				    },
				    "service2": {
				      "path": "/path/to/service2",
				      "args": [
				        "hello",
				        "world"
				      ],
				      "description": "service2 is a special service\\nfor special things",
				      "retries": 0,
				      "ignoreErrors": false,
				      "directory": "/home/cueckoo"
				    },
				    "service3": {
				      "path": "/path/to/service3",
				      "args": null,
				      "description": "service3 is a special service\\nfor special things",
				      "retries": 0,
				      "ignoreErrors": false,
				      "directory": "/home/cueckoo"
				    }
				  }
				}

				"""
		}]
	}
	create_initial_defaults: {
		StepType: 2
		Name:     "create_initial_defaults"
		Order:    23
		Terminal: "term1"
		Language: "cue"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package main

			programs: [string]: retries: *3 | _

			"""
		Target: "/home/gopher/demo/defaults.cue"
	}
	update_main_defaults: {
		StepType: 2
		Name:     "update_main_defaults"
		Order:    24
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package main

			import (
			\t_ "embed"
			\t"encoding/json"
			\t"fmt"
			\t"log"
			\t"path/filepath"

			\t"github.com/cue-exp/cueconfig"
			)

			type Config struct {
			\tPrograms map[string]Program `json:"programs"`
			}

			type Program struct {
			\tPath         string   `json:"path"`
			\tArgs         []string `json:"args"`
			\tDescription  string   `json:"description"`
			\tRetries      int      `json:"retries"`
			\tIgnoreErrors bool     `json:"ignoreErrors"`
			\tDirectory    string   `json:"directory"`
			}

			var (
			\t//go:embed schema.cue
			\tschema []byte

			\t//go:embed defaults.cue
			\tdefaults []byte
			)

			func main() {
			\t// Use a fake "$HOME" for the purposes of this demo
			\tcfpath := filepath.Join("home", ".config", "demo", "config.cue")

			\tvar conf Config
			\tif err := cueconfig.Load(cfpath, schema, defaults, nil, &conf); err != nil {
			\t\tlog.Fatal(err)
			\t}

			\tout, err := json.MarshalIndent(conf, "", "  ")
			\tif err != nil {
			\t\tlog.Fatal(err)
			\t}
			\tfmt.Printf("%s\\n", out)
			}

			"""
		Target: "/home/gopher/demo/main.go"
	}
	run_check_defaults: {
		StepType: 1
		Name:     "run_check_defaults"
		Order:    25
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				{
				  "programs": {
				    "service1": {
				      "path": "/path/to/service1",
				      "args": [
				        "hello",
				        "world"
				      ],
				      "description": "service1 is a special service\\nfor special things",
				      "retries": 3,
				      "ignoreErrors": true,
				      "directory": "/tmp"
				    },
				    "service2": {
				      "path": "/path/to/service2",
				      "args": [
				        "hello",
				        "world"
				      ],
				      "description": "service2 is a special service\\nfor special things",
				      "retries": 3,
				      "ignoreErrors": false,
				      "directory": "/home/cueckoo"
				    },
				    "service3": {
				      "path": "/path/to/service3",
				      "args": null,
				      "description": "service3 is a special service\\nfor special things",
				      "retries": 3,
				      "ignoreErrors": false,
				      "directory": "/home/cueckoo"
				    }
				  }
				}

				"""
		}]
	}
	update_main_runtime: {
		StepType: 2
		Name:     "update_main_runtime"
		Order:    26
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package main

			import (
			\t_ "embed"
			\t"encoding/json"
			\t"fmt"
			\t"log"
			\t"path/filepath"

			\t"github.com/cue-exp/cueconfig"
			)

			type Config struct {
			\tPrograms map[string]Program `json:"programs"`
			}

			type Program struct {
			\tPath         string   `json:"path"`
			\tArgs         []string `json:"args"`
			\tDescription  string   `json:"description"`
			\tRetries      int      `json:"retries"`
			\tIgnoreErrors bool     `json:"ignoreErrors"`
			\tDirectory    string   `json:"directory"`
			}

			var (
			\t//go:embed schema.cue
			\tschema []byte

			\t//go:embed defaults.cue
			\tdefaults []byte
			)

			func main() {
			\t// Use a fake "$HOME" for the purposes of this demo
			\tcfpath := filepath.Join("home", ".config", "demo", "config.cue")

			\tr := map[string]any{
			\t\t"runtime": map[string]any{
			\t\t\t"workingDirectory": "/runtime/blah",
			\t\t},
			\t}

			\tvar conf Config
			\tif err := cueconfig.Load(cfpath, schema, defaults, r, &conf); err != nil {
			\t\tlog.Fatal(err)
			\t}

			\tout, err := json.MarshalIndent(conf, "", "  ")
			\tif err != nil {
			\t\tlog.Fatal(err)
			\t}
			\tfmt.Printf("%s\\n", out)
			}

			"""
		Target: "/home/gopher/demo/main.go"
	}
	update_schema_runtime: {
		StepType: 2
		Name:     "update_schema_runtime"
		Order:    27
		Terminal: "term1"
		Language: "cue"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package main

			programs: [string]: #Program

			#Program: {
			\tpath: string
			\targs?: [...string]
			\tdescription:   string
			\tretries?:      int
			\tignoreErrors?: bool
			\tdirectory?:    string
			}

			runtime: #Runtime

			#Runtime: {
			\tworkingDirectory?: string
			}

			"""
		Target: "/home/gopher/demo/schema.cue"
	}
	update_config_runtime: {
		StepType: 2
		Name:     "update_config_runtime"
		Order:    28
		Terminal: "term1"
		Language: "cue"
		Renderer: {
			RendererType: 1
		}
		Source: #"""
			import "strings"

			runtime: _

			programs: [_name=string]: {
			\#tdirectory:   *runtime.workingDirectory | _
			\#tpath:        *"/path/to/\#\(_name)" | _
			\#tdescription: strings.HasPrefix(_name)
			}

			programs: {
			\#tservice1: {
			\#t\#tdescription: """
			\#t\#t\#tservice1 is a special service
			\#t\#t\#tfor special things
			\#t\#t\#t"""
			\#t\#targs: [
			\#t\#t\#t"hello",
			\#t\#t\#t"world",
			\#t\#t]
			\#t\#tdirectory:    "/tmp"
			\#t\#tignoreErrors: true
			\#t}
			\#tservice2: {
			\#t\#tdescription: """
			\#t\#t\#tservice2 is a special service
			\#t\#t\#tfor special things
			\#t\#t\#t"""
			\#t\#targs: service1.args,
			\#t}
			\#tservice3: {
			\#t\#tdescription: """
			\#t\#t\#tservice3 is a special service
			\#t\#t\#tfor special things
			\#t\#t\#t"""
			\#t}
			}

			"""#
		Target: "/home/gopher/demo/home/.config/demo/config.cue"
	}
	run_check_runtime: {
		StepType: 1
		Name:     "run_check_runtime"
		Order:    29
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go run ."
			ExitCode: 0
			Output: """
				{
				  "programs": {
				    "service1": {
				      "path": "/path/to/service1",
				      "args": [
				        "hello",
				        "world"
				      ],
				      "description": "service1 is a special service\\nfor special things",
				      "retries": 3,
				      "ignoreErrors": true,
				      "directory": "/tmp"
				    },
				    "service2": {
				      "path": "/path/to/service2",
				      "args": [
				        "hello",
				        "world"
				      ],
				      "description": "service2 is a special service\\nfor special things",
				      "retries": 3,
				      "ignoreErrors": false,
				      "directory": "/runtime/blah"
				    },
				    "service3": {
				      "path": "/path/to/service3",
				      "args": null,
				      "description": "service3 is a special service\\nfor special things",
				      "retries": 3,
				      "ignoreErrors": false,
				      "directory": "/runtime/blah"
				    }
				  }
				}

				"""
		}]
	}
}
Hash: "50943b1fd985cad0c022486a934dd81846e5bda9969f224cca10c6e86fda67e5"
Delims: ["{{{", "}}}"]
