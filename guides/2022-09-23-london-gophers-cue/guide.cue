// script.cue
package guide

import "github.com/play-with-go/preguide"

Defs: {
	demodir: "/home/gopher/demo"
}

Scenarios: go119: preguide.#Scenario & {
	Description: "cue v0.4.3 Go 1.19"
}

Terminals: term1: preguide.#Terminal & {
	Description: "The main terminal"
	Scenarios: go119: Image: _#cuego119LatestImage
}

Steps: cachesetup: preguide.#Command & {
	InformationOnly: true
	Stmts: """
		sudo mkdir -p /var/gocache /var/gomodcache
		sudo chown gopher:gopher /var/gocache /var/gomodcache
		"""
}

Steps: versions: preguide.#Command & {
	Stmts: [
		{
			Cmd: "go version"
		},
		{
			Cmd: "cue version"
			Sanitisers: [
				{Pattern: #"(?m)^\s+GOAMD64.*\n"#, Replacement: ""},
				{Pattern: #"^(\s*GOARCH ).*"#, LineWise:        true, Replacement: #"${1}amd64"#},
			]
		},
	]
}

Steps: startexample: preguide.#Command & {
	Stmts: """
		mkdir demo
		cd demo
		go mod init example.com/demo
		"""
}

Steps: create_initialmain: preguide.#Upload & {
	Target: "\(Defs.demodir)/main.go"
	Source: #"""
		package main

		import (
			"encoding/json"
			"fmt"
			"log"
			"os"
			"path/filepath"
		)

		type Config struct {
			Programs map[string]Program `json:"programs"`
		}

		type Program struct {
			Path         string   `json:"path"`
			Args         []string `json:"args"`
			Description  string   `json:"description"`
			Retries      int      `json:"retries"`
			IgnoreErrors bool     `json:"ignoreErrors"`
			Directory    string   `json:"directory"`
		}

		func main() {
			// Use a fake "$HOME" for the purposes of this demo
			cfpath := filepath.Join("home", ".config", "demo", "config.json")

			cf, err := os.ReadFile(cfpath)
			if err != nil {
				log.Fatal(err)
			}

			var conf Config
			if err := json.Unmarshal(cf, &conf); err != nil {
				log.Fatal(err)
			}

			out, err := json.MarshalIndent(conf, "", "  ")
			if err != nil {
				log.Fatal(err)
			}
			fmt.Printf("%s\n", out)
		}

		"""#
}

Steps: create_config_dir: preguide.#Command & {
	Stmts: """
		mkdir -p \(Defs.demodir)/home/.config/demo
		"""
}

Steps: initial_config_file: preguide.#Upload & {
	Target: "\(Defs.demodir)/home/.config/demo/config.json"
	Source: #"""
		{
			 "programs": {
				  "service1": {
						"path": "/path/to/service1",
						"description": "service1 is a special service\nfor special things",
						"args": [
							 "hello",
							 "world"
						],
						"directory": "/tmp",
						"ignoreErrors": true
				  },
				  "service2": {
						"path": "/path/to/service2",
						"description": "service2 is a special service\nfor special things",
						"args": [
							 "hello",
							 "world"
						],
						"directory": "/home/cueckoo"
				  },
				  "service3": {
						"path": "/path/to/service3",
						"description": "service3 is a special service\nfor special things",
						"directory": "/home/cueckoo"
				  }
			 }
		}
		"""#
}

Steps: run_v_json: preguide.#Command & {
	Stmts: """
		cat go.mod
		go run .
		"""
}

Steps: import_json_cue: preguide.#Command & {
	Stmts: """
		cue import ./home/.config/demo/config.json
		"""
}

Steps: inspect_initial_cue: preguide.#Command & {
	Stmts: """
		cat ./home/.config/demo/config.cue
		"""
}

Steps: export_json: preguide.#Command & {
	Stmts: """
		cue export ./home/.config/demo/config.cue
		"""
}

Steps: export_json_diff: preguide.#Command & {
	Stmts: """
		mv ./home/.config/demo/config.json ./home/.config/demo/config.json.copy
		cue export -o ./home/.config/demo/config.json ./home/.config/demo/config.cue
		diff -wu ./home/.config/demo/config.json ./home/.config/demo/config.json.copy
		"""
}

Steps: initial_main_cueconfig: preguide.#Upload & {
	Target: "\(Defs.demodir)/main.go"
	Source: #"""
		package main

		import (
			"encoding/json"
			"fmt"
			"log"
			"path/filepath"

			"github.com/cue-exp/cueconfig"
		)

		type Config struct {
			Programs map[string]Program `json:"programs"`
		}

		type Program struct {
			Path         string   `json:"path"`
			Args         []string `json:"args"`
			Description  string   `json:"description"`
			Retries      int      `json:"retries"`
			IgnoreErrors bool     `json:"ignoreErrors"`
			Directory    string   `json:"directory"`
		}

		func main() {
			// Use a fake "$HOME" for the purposes of this demo
			cfpath := filepath.Join("home", ".config", "demo", "config.cue")

			var conf Config
			if err := cueconfig.Load(cfpath, nil, nil, nil, &conf); err != nil {
				log.Fatal(err)
			}

			out, err := json.MarshalIndent(conf, "", "  ")
			if err != nil {
				log.Fatal(err)
			}
			fmt.Printf("%s\n", out)
		}

		"""#
}

Steps: get_cueconfig_and_tidy: preguide.#Command & {
	Stmts: """
		go get github.com/cue-exp/cueconfig@v0.0.1
		go mod tidy
		"""
}

Steps: run_initial_cueconfig: preguide.#Command & {
	Stmts: """
		go run .
		"""
}

Steps: create_initial_schema: preguide.#Upload & {
	Target: "\(Defs.demodir)/schema.cue"
	Source: #"""
		package main

		programs: [string]: #Program

		#Program: {
			path: string
			args?: [...string]
			description:   string
			retries?:      int
			ignoreErrors?: bool
			directory?:    string
		}

		"""#
}

Steps: update_main_schema: preguide.#Upload & {
	Target: "\(Defs.demodir)/main.go"
	Source: #"""
		package main

		import (
			_ "embed"
			"encoding/json"
			"fmt"
			"log"
			"path/filepath"

			"github.com/cue-exp/cueconfig"
		)

		type Config struct {
			Programs map[string]Program `json:"programs"`
		}

		type Program struct {
			Path         string   `json:"path"`
			Args         []string `json:"args"`
			Description  string   `json:"description"`
			Retries      int      `json:"retries"`
			IgnoreErrors bool     `json:"ignoreErrors"`
			Directory    string   `json:"directory"`
		}

		var (
			//go:embed schema.cue
			schema []byte
		)

		func main() {
			// Use a fake "$HOME" for the purposes of this demo
			cfpath := filepath.Join("home", ".config", "demo", "config.cue")

			var conf Config
			if err := cueconfig.Load(cfpath, schema, nil, nil, &conf); err != nil {
				log.Fatal(err)
			}

			out, err := json.MarshalIndent(conf, "", "  ")
			if err != nil {
				log.Fatal(err)
			}
			fmt.Printf("%s\n", out)
		}

		"""#
}

Steps: run_initial_schema: preguide.#Command & {
	Stmts: """
		go run .
		"""
}

Steps: break_config_additional_field: preguide.#Upload & {
	Target: "\(Defs.demodir)/home/.config/demo/config.cue"
	Source: #"""
		programs: {
			service1: {
				path: "/path/to/service1"
				description: """
					service1 is a special service
					for special things
					"""
				args: [
					"hello",
					"world",
				]
				directory:    "/tmp"
				ignoreErrors: true
				blah:         "something"
			}
			service2: {
				path: "/path/to/service2"
				description: """
					service2 is a special service
					for special things
					"""
				args: [
					"hello",
					"world",
				]
				directory: "/home/cueckoo"
			}
			service3: {
				path: "/path/to/service3"
				description: """
					service3 is a special service
					for special things
					"""
				directory: "/home/cueckoo"
			}
		}

		"""#
}

Steps: run_broken_config_additional_field: preguide.#Command & {
	Stmts: """
		! go run .
		"""
}

Steps: restore_config_working: preguide.#Upload & {
	Target: "\(Defs.demodir)/home/.config/demo/config.cue"
	Source: #"""
		programs: {
			service1: {
				path: "/path/to/service1"
				description: """
					service1 is a special service
					for special things
					"""
				args: [
					"hello",
					"world",
				]
				directory:    "/tmp"
				ignoreErrors: true
			}
			service2: {
				path: "/path/to/service2"
				description: """
					service2 is a special service
					for special things
					"""
				args: [
					"hello",
					"world",
				]
				directory: "/home/cueckoo"
			}
			service3: {
				path: "/path/to/service3"
				description: """
					service3 is a special service
					for special things
					"""
				directory: "/home/cueckoo"
			}
		}

		"""#
}

Steps: run_check_config_working: preguide.#Command & {
	Stmts: """
		go run .
		"""
}

Steps: modify_config_dry: preguide.#Upload & {
	Target: "\(Defs.demodir)/home/.config/demo/config.cue"
	Source: #"""
		import "strings"

		programs: [_name=string]: {
			directory:   *"/home/cueckoo" | _
			path:        *"/path/to/\(_name)" | _
			description: strings.HasPrefix(_name)
		}

		programs: {
			service1: {
				description: """
					service1 is a special service
					for special things
					"""
				args: [
					"hello",
					"world",
				]
				directory:    "/tmp"
				ignoreErrors: true
			}
			service2: {
				description: """
					service2 is a special service
					for special things
					"""
				args: service1.args,
			}
			service3: {
				description: """
					service3 is a special service
					for special things
					"""
			}
		}

		"""#
}

Steps: run_check_config_dry: preguide.#Command & {
	Stmts: """
		go run .
		"""
}

Steps: create_initial_defaults: preguide.#Upload & {
	Target: "\(Defs.demodir)/defaults.cue"
	Source: #"""
		package main

		programs: [string]: retries: *3 | _

		"""#
}

Steps: update_main_defaults: preguide.#Upload & {
	Target: "\(Defs.demodir)/main.go"
	Source: #"""
		package main

		import (
			_ "embed"
			"encoding/json"
			"fmt"
			"log"
			"path/filepath"

			"github.com/cue-exp/cueconfig"
		)

		type Config struct {
			Programs map[string]Program `json:"programs"`
		}

		type Program struct {
			Path         string   `json:"path"`
			Args         []string `json:"args"`
			Description  string   `json:"description"`
			Retries      int      `json:"retries"`
			IgnoreErrors bool     `json:"ignoreErrors"`
			Directory    string   `json:"directory"`
		}

		var (
			//go:embed schema.cue
			schema []byte

			//go:embed defaults.cue
			defaults []byte
		)

		func main() {
			// Use a fake "$HOME" for the purposes of this demo
			cfpath := filepath.Join("home", ".config", "demo", "config.cue")

			var conf Config
			if err := cueconfig.Load(cfpath, schema, defaults, nil, &conf); err != nil {
				log.Fatal(err)
			}

			out, err := json.MarshalIndent(conf, "", "  ")
			if err != nil {
				log.Fatal(err)
			}
			fmt.Printf("%s\n", out)
		}

		"""#
}

Steps: run_check_defaults: preguide.#Command & {
	Stmts: """
		go run .
		"""
}

Steps: update_main_runtime: preguide.#Upload & {
	Target: "\(Defs.demodir)/main.go"
	Source: #"""
		package main

		import (
			_ "embed"
			"encoding/json"
			"fmt"
			"log"
			"path/filepath"

			"github.com/cue-exp/cueconfig"
		)

		type Config struct {
			Programs map[string]Program `json:"programs"`
		}

		type Program struct {
			Path         string   `json:"path"`
			Args         []string `json:"args"`
			Description  string   `json:"description"`
			Retries      int      `json:"retries"`
			IgnoreErrors bool     `json:"ignoreErrors"`
			Directory    string   `json:"directory"`
		}

		var (
			//go:embed schema.cue
			schema []byte

			//go:embed defaults.cue
			defaults []byte
		)

		func main() {
			// Use a fake "$HOME" for the purposes of this demo
			cfpath := filepath.Join("home", ".config", "demo", "config.cue")

			r := map[string]any{
				"runtime": map[string]any{
					"workingDirectory": "/runtime/blah",
				},
			}

			var conf Config
			if err := cueconfig.Load(cfpath, schema, defaults, r, &conf); err != nil {
				log.Fatal(err)
			}

			out, err := json.MarshalIndent(conf, "", "  ")
			if err != nil {
				log.Fatal(err)
			}
			fmt.Printf("%s\n", out)
		}

		"""#
}

Steps: update_schema_runtime: preguide.#Upload & {
	Target: "\(Defs.demodir)/schema.cue"
	Source: #"""
		package main

		programs: [string]: #Program

		#Program: {
			path: string
			args?: [...string]
			description:   string
			retries?:      int
			ignoreErrors?: bool
			directory?:    string
		}

		runtime: #Runtime

		#Runtime: {
			workingDirectory?: string
		}

		"""#
}

Steps: update_config_runtime: preguide.#Upload & {
	Target: "\(Defs.demodir)/home/.config/demo/config.cue"
	Source: #"""
		import "strings"

		runtime: _

		programs: [_name=string]: {
			directory:   *runtime.workingDirectory | _
			path:        *"/path/to/\(_name)" | _
			description: strings.HasPrefix(_name)
		}

		programs: {
			service1: {
				description: """
					service1 is a special service
					for special things
					"""
				args: [
					"hello",
					"world",
				]
				directory:    "/tmp"
				ignoreErrors: true
			}
			service2: {
				description: """
					service2 is a special service
					for special things
					"""
				args: service1.args,
			}
			service3: {
				description: """
					service3 is a special service
					for special things
					"""
			}
		}

		"""#
}

Steps: run_check_runtime: preguide.#Command & {
	Stmts: """
		go run .
		"""
}
