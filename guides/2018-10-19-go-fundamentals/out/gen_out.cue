package out

Presteps: [{
	Package: "github.com/play-with-go/gitea"
	Path:    "/newuser"
	Args: {
		Repos: [{
			Pattern: "greetings"
			Private: false
			Var:     "GREETINGS"
		}, {
			Pattern: "hello"
			Private: false
			Var:     "HELLO"
		}]
	}
	Version: """
		{
		  "GoVersion": "go1.19.1",
		  "Path": "github.com/play-with-go/gitea/cmd/gitea",
		  "Main": {
		    "Path": "github.com/play-with-go/gitea",
		    "Version": "v0.0.0-20221003164140-c14d636df530",
		    "Sum": "h1:RDNvyzwtVgtV0xOEaQL+CziEPkar/gNPyQUaWdnYjGk=",
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
		      "Version": "v0.0.2-0.20221003193111-f84a6637f25f",
		      "Sum": "h1:ijMtjVmmzO13W4+wfOng8tkYFBJN+VRuw/znwVm7x68=",
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
	Variables: ["GITEA_USERNAME", "GITEA_PRIV_KEY", "GITEA_PUB_KEY", "GITEA_KEYSCAN", "GREETINGS", "HELLO"]
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
Steps: {
	goversion: {
		StepType: 1
		Name:     "goversion"
		Order:    0
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go version"
			ExitCode: 0
			Output: """
				go version go1.19.1 linux/amd64

				"""
		}]
	}
	pwd_home: {
		StepType: 1
		Name:     "pwd_home"
		Order:    1
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "pwd"
			ExitCode: 0
			Output: """
				/home/gopher

				"""
		}]
	}
	mkdir_greetings: {
		StepType: 1
		Name:     "mkdir_greetings"
		Order:    2
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "mkdir /home/gopher/greetings"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "cd /home/gopher/greetings"
			ExitCode: 0
			Output:   ""
		}]
	}
	gomodinit_greetings: {
		StepType: 1
		Name:     "gomodinit_greetings"
		Order:    3
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go mod init {{{.GREETINGS}}}"
			ExitCode: 0
			Output: """
				go: creating new go.mod: module {{{.GREETINGS}}}

				"""
		}]
	}
	cat_gomodgreetings: {
		StepType: 1
		Name:     "cat_gomodgreetings"
		Order:    4
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "cat go.mod"
			ExitCode: 0
			Output: """
				module {{{.GREETINGS}}}

				go 1.19

				"""
		}]
	}
	create_greetingsgo: {
		StepType: 2
		Name:     "create_greetingsgo"
		Order:    5
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package greetings

			import "fmt"

			// Hello returns a greeting for the named person.
			func Hello(name string) string {
			\t// Return a greeting that embeds the name in a message.
			\tmessage := fmt.Sprintf("Hi, %v. Welcome!", name)
			\treturn message
			}

			"""
		Target: "/home/gopher/greetings/greetings.go"
	}
	create_greetingsgo_long: {
		StepType: 2
		Name:     "create_greetingsgo_long"
		Order:    6
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 3
			Pre: """
				package greetings

				import "fmt"

				// Hello returns a greeting for the named person.
				func Hello(name string) string {
				\t// Return a greeting that embeds the name in a message.
				\tmessage := fmt.Sprintf("Hi, %v. Welcome!", name)
				\treturn message
				}

				"""
		}
		Source: """
			package greetings

			import "fmt"

			// Hello returns a greeting for the named person.
			func Hello(name string) string {
			\t// Return a greeting that embeds the name in a message.
			\tvar message string
			\tmessage = fmt.Sprintf("Hi, %v. Welcome!", name)
			\treturn message
			}

			"""
		Target: "/home/gopher/greetings/greetings.go"
	}
	greetings_gitinit: {
		StepType: 1
		Name:     "greetings_gitinit"
		Order:    7
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "git init -q"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git remote add origin https://{{{.GREETINGS}}}.git"
			ExitCode: 0
			Output:   ""
		}]
	}
	greetings_gitadd: {
		StepType: 1
		Name:     "greetings_gitadd"
		Order:    8
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "git add go.mod greetings.go"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git commit -q -m 'Initial commit'"
			ExitCode: 0
			Output:   ""
		}]
	}
	greetings_check_porcelain: {
		StepType:        1
		InformationOnly: true
		Name:            "greetings_check_porcelain"
		Order:           9
		Terminal:        "term1"
		Stmts: [{
			CmdStr:   "[ \"$(git status --porcelain)\" == \"\" ] || (git status && false)"
			ExitCode: 0
			Output:   ""
		}]
	}
	greetings_gitpush: {
		StepType: 1
		Name:     "greetings_gitpush"
		Order:    10
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "git push -q origin main"
			ExitCode: 0
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}]
	}
	mkdir_hello: {
		StepType: 1
		Name:     "mkdir_hello"
		Order:    11
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "mkdir /home/gopher/hello"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "cd /home/gopher/hello"
			ExitCode: 0
			Output:   ""
		}]
	}
	gomodinit_hello: {
		StepType: 1
		Name:     "gomodinit_hello"
		Order:    12
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go mod init {{{.HELLO}}}"
			ExitCode: 0
			Output: """
				go: creating new go.mod: module {{{.HELLO}}}

				"""
		}]
	}
	goget_greetings: {
		StepType: 1
		Name:     "goget_greetings"
		Order:    13
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go get {{{.GREETINGS}}}"
			ExitCode: 0
			Output: """
				go: downloading {{{.GREETINGS}}} v0.0.0-20060102150405-abcedf12345
				go: added {{{.GREETINGS}}} v0.0.0-20060102150405-abcedf12345

				"""
		}]
	}
	golist_greetings: {
		StepType:        1
		InformationOnly: true
		Name:            "golist_greetings"
		Order:           14
		Terminal:        "term1"
		Stmts: [{
			CmdStr:   "go list -m -f {{.Version}} {{{.GREETINGS}}}"
			ExitCode: 0
			Output: """
				v0.0.0-20060102150405-abcedf12345

				"""
			RandomReplace: "v0.0.0-20060102150405-abcedf12345"
		}]
	}
	create_hellogo: {
		StepType: 2
		Name:     "create_hellogo"
		Order:    15
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package main

			import (
			\t"fmt"

			\t"{{{.GREETINGS}}}"
			)

			func main() {
			\t// Get a greeting message and print it.
			\tmessage := greetings.Hello("Gladys")
			\tfmt.Println(message)
			}

			"""
		Target: "/home/gopher/hello/hello.go"
	}
	buildrun_hello: {
		StepType: 1
		Name:     "buildrun_hello"
		Order:    16
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go build"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "./hello"
			ExitCode: 0
			Output: """
				Hi, Gladys. Welcome!

				"""
		}]
	}
	cd_greetings: {
		StepType: 1
		Name:     "cd_greetings"
		Order:    17
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "cd /home/gopher/greetings"
			ExitCode: 0
			Output:   ""
		}]
	}
	update_greetings_go: {
		StepType: 2
		Name:     "update_greetings_go"
		Order:    18
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 3
			Pre: """
				package greetings

				import "fmt"

				// Hello returns a greeting for the named person.
				func Hello(name string) string {
				\t// Return a greeting that embeds the name in a message.
				\tvar message string
				\tmessage = fmt.Sprintf("Hi, %v. Welcome!", name)
				\treturn message
				}

				"""
		}
		Source: """
			package greetings

			import (
			\t"errors"
			\t"fmt"
			)

			// Hello returns a greeting for the named person.
			func Hello(name string) (string, error) {
			\t// If no name was given, return an error with a message.
			\tif name == "" {
			\t\treturn "", errors.New("empty name")
			\t}

			\t// If a name was received, return a value that embeds the name
			\t// in a greeting message.
			\tmessage := fmt.Sprintf("Hi, %v. Welcome!", name)
			\treturn message, nil
			}

			"""
		Target: "/home/gopher/greetings/greetings.go"
	}
	commit_greetings_error_handling: {
		StepType: 1
		Name:     "commit_greetings_error_handling"
		Order:    19
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "git add greetings.go"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git commit -q -m 'Added error handling'"
			ExitCode: 0
			Output:   ""
		}]
	}
	greetings_check_error_handling_porcelain: {
		StepType:        1
		InformationOnly: true
		Name:            "greetings_check_error_handling_porcelain"
		Order:           20
		Terminal:        "term1"
		Stmts: [{
			CmdStr:   "[ \"$(git status --porcelain)\" == \"\" ] || (git status && false)"
			ExitCode: 0
			Output:   ""
		}]
	}
	greetings_error_commit: {
		StepType: 1
		Name:     "greetings_error_commit"
		Order:    21
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "greetings_error_commit=$(git rev-parse HEAD)"
			ExitCode: 0
			Output:   ""
		}]
	}
	echo_greetings_error_commit: {
		StepType:        1
		InformationOnly: true
		Name:            "echo_greetings_error_commit"
		Order:           22
		Terminal:        "term1"
		Stmts: [{
			CmdStr:   "git rev-parse HEAD"
			ExitCode: 0
			Output: """
				v0.0.0-20060102150405-abcedf12345

				"""
			RandomReplace: "v0.0.0-20060102150405-abcedf12345"
		}]
	}
	republish_greetings: {
		StepType: 1
		Name:     "republish_greetings"
		Order:    23
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "git push -q origin main"
			ExitCode: 0
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}]
	}
	cd_hello: {
		StepType: 1
		Name:     "cd_hello"
		Order:    24
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "cd /home/gopher/hello"
			ExitCode: 0
			Output:   ""
		}]
	}
	get_latest_greetings: {
		StepType: 1
		Name:     "get_latest_greetings"
		Order:    25
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go get {{{.GREETINGS}}}@$greetings_error_commit"
			ExitCode: 0
			Output: """
				go: downloading {{{.GREETINGS}}} v0.0.0-20060102150405-abcedf12345
				go: upgraded {{{.GREETINGS}}} v0.0.0-20060102150405-abcedf12345 => v0.0.0-20060102150405-abcedf12345

				"""
		}]
	}
	golist_latest_greetings: {
		StepType:        1
		InformationOnly: true
		Name:            "golist_latest_greetings"
		Order:           26
		Terminal:        "term1"
		Stmts: [{
			CmdStr:   "go list -m -f {{.Version}} {{{.GREETINGS}}}"
			ExitCode: 0
			Output: """
				v0.0.0-20060102150405-abcedf12345

				"""
			RandomReplace: "v0.0.0-20060102150405-abcedf12345"
		}]
	}
	update_hello_go_error: {
		StepType: 2
		Name:     "update_hello_go_error"
		Order:    27
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 3
			Pre: """
				package main

				import (
				\t"fmt"

				\t"{{{.GREETINGS}}}"
				)

				func main() {
				\t// Get a greeting message and print it.
				\tmessage := greetings.Hello("Gladys")
				\tfmt.Println(message)
				}

				"""
		}
		Source: """
			package main

			import (
			\t"fmt"
			\t"log"

			\t"{{{.GREETINGS}}}"
			)

			func main() {
			\t// Set properties of the predefined Logger, including
			\t// the log entry prefix and a flag to disable printing
			\t// the time, source file, and line number.
			\tlog.SetPrefix("greetings: ")
			\tlog.SetFlags(0)

			\t// Request a greeting message.
			\tmessage, err := greetings.Hello("")
			\t// If an error was returned, print it to the console and
			\t// exit the program.
			\tif err != nil {
			\t\tlog.Fatal(err)
			\t}

			\t// If no error was returned, print the returned message
			\t// to the console.
			\tfmt.Println(message)
			}

			"""
		Target: "/home/gopher/hello/hello.go"
	}
	run_hello_error: {
		StepType: 1
		Name:     "run_hello_error"
		Order:    28
		Terminal: "term1"
		Stmts: [{
			Negated:  true
			CmdStr:   "go run hello.go"
			ExitCode: 1
			Output: """
				greetings: empty name
				exit status 1

				"""
		}]
	}
	cd_greetings_random: {
		StepType: 1
		Name:     "cd_greetings_random"
		Order:    29
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "cd /home/gopher/greetings"
			ExitCode: 0
			Output:   ""
		}]
	}
	update_greetings_go_random: {
		StepType: 2
		Name:     "update_greetings_go_random"
		Order:    30
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 3
			Pre: """
				package greetings

				import "fmt"

				// Hello returns a greeting for the named person.
				func Hello(name string) string {
				\t// Return a greeting that embeds the name in a message.
				\tmessage := fmt.Sprintf("Hi, %v. Welcome!", name)
				\treturn message
				}

				"""
		}
		Source: """
			package greetings

			import (
			\t"errors"
			\t"fmt"
			\t"math/rand"
			)

			// Hello returns a greeting for the named person.
			func Hello(name string) (string, error) {
			\t// If no name was given, return an error with a message.
			\tif name == "" {
			\t\treturn name, errors.New("empty name")
			\t}
			\t// Create a message using a random format.
			\tmessage := fmt.Sprintf(randomFormat(), name)
			\treturn message, nil
			}

			// init sets initial values for variables used in the function.
			func init() {
			\t// For truly random greetings, import "time" and replace the call
			\t// to rand.Seed with:
			\t//
			\t// rand.Seed(time.Now().UnixNano())
			\t//
			\t// Calling rand.Seed with a constant value means that we always
			\t// generate the same pseudo-random sequence.
			\trand.Seed(1)
			}

			// randomFormat returns one of a set of greeting messages. The returned
			// message is selected at random.
			func randomFormat() string {
			\t// A slice of message formats.
			\tformats := []string{
			\t\t"Hi, %v. Welcome!",
			\t\t"Great to see you, %v!",
			\t\t"Hail, %v! Well met!",
			\t}

			\t// Return one of the message formats selected at random.
			\treturn formats[rand.Intn(len(formats))]
			}

			"""
		Target: "/home/gopher/greetings/greetings.go"
	}
	greeings_commit_random: {
		StepType: 1
		Name:     "greeings_commit_random"
		Order:    31
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "git add greetings.go"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "git commit -q -m 'Added random format'"
			ExitCode: 0
			Output:   ""
		}]
	}
	greetings_check_random_porcelain: {
		StepType:        1
		InformationOnly: true
		Name:            "greetings_check_random_porcelain"
		Order:           32
		Terminal:        "term1"
		Stmts: [{
			CmdStr:   "[ \"$(git status --porcelain)\" == \"\" ] || (git status && false)"
			ExitCode: 0
			Output:   ""
		}]
	}
	greetings_random_commit: {
		StepType: 1
		Name:     "greetings_random_commit"
		Order:    33
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "greetings_random_commit=$(git rev-parse HEAD)"
			ExitCode: 0
			Output:   ""
		}]
	}
	greetings_echo_random_commit: {
		StepType:        1
		InformationOnly: true
		Name:            "greetings_echo_random_commit"
		Order:           34
		Terminal:        "term1"
		Stmts: [{
			CmdStr:   "git rev-parse HEAD"
			ExitCode: 0
			Output: """
				v0.0.0-20060102150405-abcedf12345

				"""
			RandomReplace: "v0.0.0-20060102150405-abcedf12345"
		}]
	}
	greetings_publish_random: {
		StepType: 1
		Name:     "greetings_publish_random"
		Order:    35
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "git push -q origin main"
			ExitCode: 0
			Output: """
				remote: . Processing 1 references        
				remote: Processed 1 references in total        

				"""
		}]
	}
	hello_use_random: {
		StepType: 1
		Name:     "hello_use_random"
		Order:    36
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "cd /home/gopher/hello"
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "go get {{{.GREETINGS}}}@$greetings_random_commit"
			ExitCode: 0
			Output: """
				go: downloading {{{.GREETINGS}}} v0.0.0-20060102150405-abcedf12345
				go: upgraded {{{.GREETINGS}}} v0.0.0-20060102150405-abcedf12345 => v0.0.0-20060102150405-abcedf12345

				"""
		}]
	}
	hello_golist_random_greetings: {
		StepType:        1
		InformationOnly: true
		Name:            "hello_golist_random_greetings"
		Order:           37
		Terminal:        "term1"
		Stmts: [{
			CmdStr:   "go list -m -f {{.Version}} {{{.GREETINGS}}}"
			ExitCode: 0
			Output: """
				v0.0.0-20060102150405-abcedf12345

				"""
			RandomReplace: "v0.0.0-20060102150405-abcedf12345"
		}]
	}
	hello_go_readd_gladys: {
		StepType: 2
		Name:     "hello_go_readd_gladys"
		Order:    38
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 3
			Pre: """
				package main

				import (
				\t"fmt"
				\t"log"

				\t"{{{.GREETINGS}}}"
				)

				func main() {
				\t// Set properties of the predefined Logger, including
				\t// the log entry prefix and a flag to disable printing
				\t// the time, source file, and line number.
				\tlog.SetPrefix("greetings: ")
				\tlog.SetFlags(0)

				\t// Request a greeting message.
				\tmessage, err := greetings.Hello("")
				\t// If an error was returned, print it to the console and
				\t// exit the program.
				\tif err != nil {
				\t\tlog.Fatal(err)
				\t}

				\t// If no error was returned, print the returned message
				\t// to the console.
				\tfmt.Println(message)
				}

				"""
		}
		Source: """
			package main

			import (
			\t"fmt"
			\t"log"

			\t"{{{.GREETINGS}}}"
			)

			func main() {
			\t// Set properties of the predefined Logger, including
			\t// the log entry prefix and a flag to disable printing
			\t// the time, source file, and line number.
			\tlog.SetPrefix("greetings: ")
			\tlog.SetFlags(0)

			\t// Request a greeting message.
			\tmessage, err := greetings.Hello("Gladys")
			\t// If an error was returned, print it to the console and
			\t// exit the program.
			\tif err != nil {
			\t\tlog.Fatal(err)
			\t}

			\t// If no error was returned, print the returned message
			\t// to the console.
			\tfmt.Println(message)
			}

			"""
		Target: "/home/gopher/hello/hello.go"
	}
	hello_run_random: {
		StepType: 1
		Name:     "hello_run_random"
		Order:    39
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go run hello.go"
			ExitCode: 0
			Output: """
				Hail, Gladys! Well met!

				"""
		}, {
			CmdStr:   "go run hello.go"
			ExitCode: 0
			Output: """
				Hail, Gladys! Well met!

				"""
		}]
	}
	greetings_start_multiple: {
		StepType: 1
		Name:     "greetings_start_multiple"
		Order:    40
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "cd /home/gopher/greetings"
			ExitCode: 0
			Output:   ""
		}]
	}
	greetings_go_multiple_people: {
		StepType: 2
		Name:     "greetings_go_multiple_people"
		Order:    41
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 3
			Pre: """
				package greetings

				import (
				\t"errors"
				\t"fmt"
				\t"math/rand"
				)

				// Hello returns a greeting for the named person.
				func Hello(name string) (string, error) {
				\t// If no name was given, return an error with a message.
				\tif name == "" {
				\t\treturn name, errors.New("empty name")
				\t}
				\t// Create a message using a random format.
				\tmessage := fmt.Sprintf(randomFormat(), name)
				\treturn message, nil
				}

				// init sets initial values for variables used in the function.
				func init() {
				\t// For truly random greetings, import "time" and replace the call
				\t// to rand.Seed with:
				\t//
				\t// rand.Seed(time.Now().UnixNano())
				\t//
				\t// Calling rand.Seed with a constant value means that we always
				\t// generate the same pseudo-random sequence.
				\trand.Seed(1)
				}

				// randomFormat returns one of a set of greeting messages. The returned
				// message is selected at random.
				func randomFormat() string {
				\t// A slice of message formats.
				\tformats := []string{
				\t\t"Hi, %v. Welcome!",
				\t\t"Great to see you, %v!",
				\t\t"Hail, %v! Well met!",
				\t}

				\t// Return one of the message formats selected at random.
				\treturn formats[rand.Intn(len(formats))]
				}

				"""
		}
		Source: """
			package greetings

			import (
			\t"errors"
			\t"fmt"
			\t"math/rand"
			)

			// Hello returns a greeting for the named person.
			func Hello(name string) (string, error) {
			\t// If no name was given, return an error with a message.
			\tif name == "" {
			\t\treturn name, errors.New("empty name")
			\t}
			\t// Create a message using a random format.
			\tmessage := fmt.Sprintf(randomFormat(), name)
			\treturn message, nil
			}

			// Hellos returns a map that associates each of the named people
			// with a greeting message.
			func Hellos(names []string) (map[string]string, error) {
			\t// A map to associate names with messages.
			\tmessages := make(map[string]string)
			\t// Loop through the received slice of names, calling
			\t// the Hello function to get a message for each name.
			\tfor _, name := range names {
			\t\tmessage, err := Hello(name)
			\t\tif err != nil {
			\t\t\treturn nil, err
			\t\t}
			\t\t// In the map, associate the retrieved message with
			\t\t// the name.
			\t\tmessages[name] = message
			\t}
			\treturn messages, nil
			}

			// init sets initial values for variables used in the function.
			func init() {
			\t// For truly random greetings, import "time" and replace the call
			\t// to rand.Seed with:
			\t//
			\t// rand.Seed(time.Now().UnixNano())
			\t//
			\t// Calling rand.Seed with a constant value means that we always
			\t// generate the same pseudo-random sequence.
			\trand.Seed(1)
			}

			// randomFormat returns one of a set of greeting messages. The returned
			// message is selected at random.
			func randomFormat() string {
			\t// A slice of message formats.
			\tformats := []string{
			\t\t"Hi, %v. Welcome!",
			\t\t"Great to see you, %v!",
			\t\t"Hail, %v! Well met!",
			\t}

			\t// Return one of the message formats selected at random.
			\treturn formats[rand.Intn(len(formats))]
			}

			"""
		Target: "/home/gopher/greetings/greetings.go"
	}
	hello_use_multiple: {
		StepType: 1
		Name:     "hello_use_multiple"
		Order:    42
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "cd /home/gopher/hello"
			ExitCode: 0
			Output:   ""
		}]
	}
	hello_replace_greetings: {
		StepType: 1
		Name:     "hello_replace_greetings"
		Order:    43
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go mod edit -replace {{{.GREETINGS}}}=/home/gopher/greetings"
			ExitCode: 0
			Output:   ""
		}]
	}
	hello_cat_go_mod_replace: {
		StepType: 1
		Name:     "hello_cat_go_mod_replace"
		Order:    44
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "cat go.mod"
			ExitCode: 0
			Output: """
				module {{{.HELLO}}}

				go 1.19

				require {{{.GREETINGS}}} v0.0.0-20060102150405-abcedf12345 // indirect

				replace {{{.GREETINGS}}} => /home/gopher/greetings

				"""
		}]
	}
	hello_go_call_multiple: {
		StepType: 2
		Name:     "hello_go_call_multiple"
		Order:    45
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 3
			Pre: """
				package main

				import (
				\t"fmt"
				\t"log"

				\t"{{{.GREETINGS}}}"
				)

				func main() {
				\t// Set properties of the predefined Logger, including
				\t// the log entry prefix and a flag to disable printing
				\t// the time, source file, and line number.
				\tlog.SetPrefix("greetings: ")
				\tlog.SetFlags(0)

				\t// Request a greeting message.
				\tmessage, err := greetings.Hello("Gladys")
				\t// If an error was returned, print it to the console and
				\t// exit the program.
				\tif err != nil {
				\t\tlog.Fatal(err)
				\t}

				\t// If no error was returned, print the returned message
				\t// to the console.
				\tfmt.Println(message)
				}

				"""
		}
		Source: """
			package main

			import (
			\t"fmt"
			\t"log"

			\t"{{{.GREETINGS}}}"
			)

			func main() {
			\t// Set properties of the predefined Logger, including
			\t// the log entry prefix and a flag to disable printing
			\t// the time, source file, and line number.
			\tlog.SetPrefix("greetings: ")
			\tlog.SetFlags(0)

			\t// A slice of names.
			\tnames := []string{"Gladys", "Samantha", "Darrin"}

			\t// Request greeting messages for the names.
			\tmessages, err := greetings.Hellos(names)
			\tif err != nil {
			\t\tlog.Fatal(err)
			\t}
			\t// If no error was returned, print the returned map of
			\t// messages to the console.
			\tfmt.Println(messages)
			}

			"""
		Target: "/home/gopher/hello/hello.go"
	}
	hello_run_multiple: {
		StepType: 1
		Name:     "hello_run_multiple"
		Order:    46
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go run hello.go"
			ExitCode: 0
			Output: """
				map[Darrin:Hail, Darrin! Well met! Gladys:Hail, Gladys! Well met! Samantha:Hi, Samantha. Welcome!]

				"""
		}]
	}
	greetings_return_to_write_test: {
		StepType: 1
		Name:     "greetings_return_to_write_test"
		Order:    47
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "cd /home/gopher/greetings"
			ExitCode: 0
			Output:   ""
		}]
	}
	greetings_create_greetings_test_go: {
		StepType: 2
		Name:     "greetings_create_greetings_test_go"
		Order:    48
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package greetings

			import (
			\t"regexp"
			\t"testing"
			)

			// TestHelloName calls greetings.Hello with a name, checking
			// for a valid return value.
			func TestHelloName(t *testing.T) {
			\tname := "Gladys"
			\twant := regexp.MustCompile(`\\b` + name + `\\b`)
			\tmsg, err := Hello(name)
			\tif !want.MatchString(msg) || err != nil {
			\t\tt.Fatalf(`Hello("Gladys") = %q, %v, want match for %#q, <nil>`, msg, err, want)
			\t}
			}

			// TestHelloEmpty calls greetings.Hello with an empty string,
			// checking for an error.
			func TestHelloEmpty(t *testing.T) {
			\tmsg, err := Hello("")
			\tif msg != "" || err == nil {
			\t\tt.Fatalf(`Hello("") = %q, %v, want "", error`, msg, err)
			\t}
			}

			"""
		Target: "/home/gopher/greetings/greetings_test.go"
	}
	greetings_run_tests: {
		StepType: 1
		Name:     "greetings_run_tests"
		Order:    49
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go test"
			ExitCode: 0
			Output: """
				PASS
				ok  \t{{{.GREETINGS}}}\t0.001s

				"""
		}, {
			CmdStr:   "go test -v"
			ExitCode: 0
			Output: """
				=== RUN   TestHelloName
				--- PASS: TestHelloName (0.00s)
				=== RUN   TestHelloEmpty
				--- PASS: TestHelloEmpty (0.00s)
				PASS
				ok  \t{{{.GREETINGS}}}\t0.001s

				"""
		}]
	}
	greetings_go_break: {
		StepType: 2
		Name:     "greetings_go_break"
		Order:    50
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 3
			Pre: """
				package greetings

				import (
				\t"errors"
				\t"fmt"
				\t"math/rand"
				)

				// Hello returns a greeting for the named person.
				func Hello(name string) (string, error) {
				\t// If no name was given, return an error with a message.
				\tif name == "" {
				\t\treturn name, errors.New("empty name")
				\t}
				\t// Create a message using a random format.
				\tmessage := fmt.Sprintf(randomFormat(), name)
				\treturn message, nil
				}

				// Hellos returns a map that associates each of the named people
				// with a greeting message.
				func Hellos(names []string) (map[string]string, error) {
				\t// A map to associate names with messages.
				\tmessages := make(map[string]string)
				\t// Loop through the received slice of names, calling
				\t// the Hello function to get a message for each name.
				\tfor _, name := range names {
				\t\tmessage, err := Hello(name)
				\t\tif err != nil {
				\t\t\treturn nil, err
				\t\t}
				\t\t// In the map, associate the retrieved message with
				\t\t// the name.
				\t\tmessages[name] = message
				\t}
				\treturn messages, nil
				}

				// init sets initial values for variables used in the function.
				func init() {
				\t// For truly random greetings, import "time" and replace the call
				\t// to rand.Seed with:
				\t//
				\t// rand.Seed(time.Now().UnixNano())
				\t//
				\t// Calling rand.Seed with a constant value means that we always
				\t// generate the same pseudo-random sequence.
				\trand.Seed(1)
				}

				// randomFormat returns one of a set of greeting messages. The returned
				// message is selected at random.
				func randomFormat() string {
				\t// A slice of message formats.
				\tformats := []string{
				\t\t"Hi, %v. Welcome!",
				\t\t"Great to see you, %v!",
				\t\t"Hail, %v! Well met!",
				\t}

				\t// Return one of the message formats selected at random.
				\treturn formats[rand.Intn(len(formats))]
				}

				"""
		}
		Source: """
			package greetings

			import (
			\t"errors"
			\t"fmt"
			\t"math/rand"
			)

			// Hello returns a greeting for the named person.
			func Hello(name string) (string, error) {
			\t// If no name was given, return an error with a message.
			\tif name == "" {
			\t\treturn name, errors.New("empty name")
			\t}
			\t// Create a message using a random format.
			\t// message := fmt.Sprintf(randomFormat(), name)
			\tmessage := fmt.Sprint(randomFormat())
			\treturn message, nil
			}

			// Hellos returns a map that associates each of the named people
			// with a greeting message.
			func Hellos(names []string) (map[string]string, error) {
			\t// A map to associate names with messages.
			\tmessages := make(map[string]string)
			\t// Loop through the received slice of names, calling
			\t// the Hello function to get a message for each name.
			\tfor _, name := range names {
			\t\tmessage, err := Hello(name)
			\t\tif err != nil {
			\t\t\treturn nil, err
			\t\t}
			\t\t// In the map, associate the retrieved message with
			\t\t// the name.
			\t\tmessages[name] = message
			\t}
			\treturn messages, nil
			}

			// init sets initial values for variables used in the function.
			func init() {
			\t// For truly random greetings, import "time" and replace the call
			\t// to rand.Seed with:
			\t//
			\t// rand.Seed(time.Now().UnixNano())
			\t//
			\t// Calling rand.Seed with a constant value means that we always
			\t// generate the same pseudo-random sequence.
			\trand.Seed(1)
			}

			// randomFormat returns one of a set of greeting messages. The returned
			// message is selected at random.
			func randomFormat() string {
			\t// A slice of message formats.
			\tformats := []string{
			\t\t"Hi, %v. Welcome!",
			\t\t"Great to see you, %v!",
			\t\t"Hail, %v! Well met!",
			\t}

			\t// Return one of the message formats selected at random.
			\treturn formats[rand.Intn(len(formats))]
			}

			"""
		Target: "/home/gopher/greetings/greetings.go"
	}
	greetings_run_tests_fail: {
		StepType: 1
		Name:     "greetings_run_tests_fail"
		Order:    51
		Terminal: "term1"
		Stmts: [{
			Negated:  true
			CmdStr:   "go test"
			ExitCode: 1
			Output: """
				--- FAIL: TestHelloName (0.00s)
				    greetings_test.go:15: Hello("Gladys") = "Hail, %v! Well met!", <nil>, want match for `\\bGladys\\b`, <nil>
				FAIL
				exit status 1
				FAIL\t{{{.GREETINGS}}}\t0.001s

				"""
		}]
	}
	greetings_go_restore: {
		StepType: 2
		Name:     "greetings_go_restore"
		Order:    52
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 3
			Pre: """
				package greetings

				import (
				\t"errors"
				\t"fmt"
				\t"math/rand"
				)

				// Hello returns a greeting for the named person.
				func Hello(name string) (string, error) {
				\t// If no name was given, return an error with a message.
				\tif name == "" {
				\t\treturn name, errors.New("empty name")
				\t}
				\t// Create a message using a random format.
				\t// message := fmt.Sprintf(randomFormat(), name)
				\tmessage := fmt.Sprint(randomFormat())
				\treturn message, nil
				}

				// Hellos returns a map that associates each of the named people
				// with a greeting message.
				func Hellos(names []string) (map[string]string, error) {
				\t// A map to associate names with messages.
				\tmessages := make(map[string]string)
				\t// Loop through the received slice of names, calling
				\t// the Hello function to get a message for each name.
				\tfor _, name := range names {
				\t\tmessage, err := Hello(name)
				\t\tif err != nil {
				\t\t\treturn nil, err
				\t\t}
				\t\t// In the map, associate the retrieved message with
				\t\t// the name.
				\t\tmessages[name] = message
				\t}
				\treturn messages, nil
				}

				// init sets initial values for variables used in the function.
				func init() {
				\t// For truly random greetings, import "time" and replace the call
				\t// to rand.Seed with:
				\t//
				\t// rand.Seed(time.Now().UnixNano())
				\t//
				\t// Calling rand.Seed with a constant value means that we always
				\t// generate the same pseudo-random sequence.
				\trand.Seed(1)
				}

				// randomFormat returns one of a set of greeting messages. The returned
				// message is selected at random.
				func randomFormat() string {
				\t// A slice of message formats.
				\tformats := []string{
				\t\t"Hi, %v. Welcome!",
				\t\t"Great to see you, %v!",
				\t\t"Hail, %v! Well met!",
				\t}

				\t// Return one of the message formats selected at random.
				\treturn formats[rand.Intn(len(formats))]
				}

				"""
		}
		Source: """
			package greetings

			import (
			\t"errors"
			\t"fmt"
			\t"math/rand"
			)

			// Hello returns a greeting for the named person.
			func Hello(name string) (string, error) {
			\t// If no name was given, return an error with a message.
			\tif name == "" {
			\t\treturn name, errors.New("empty name")
			\t}
			\t// Create a message using a random format.
			\tmessage := fmt.Sprintf(randomFormat(), name)
			\treturn message, nil
			}

			// Hellos returns a map that associates each of the named people
			// with a greeting message.
			func Hellos(names []string) (map[string]string, error) {
			\t// A map to associate names with messages.
			\tmessages := make(map[string]string)
			\t// Loop through the received slice of names, calling
			\t// the Hello function to get a message for each name.
			\tfor _, name := range names {
			\t\tmessage, err := Hello(name)
			\t\tif err != nil {
			\t\t\treturn nil, err
			\t\t}
			\t\t// In the map, associate the retrieved message with
			\t\t// the name.
			\t\tmessages[name] = message
			\t}
			\treturn messages, nil
			}

			// init sets initial values for variables used in the function.
			func init() {
			\t// For truly random greetings, import "time" and replace the call
			\t// to rand.Seed with:
			\t//
			\t// rand.Seed(time.Now().UnixNano())
			\t//
			\t// Calling rand.Seed with a constant value means that we always
			\t// generate the same pseudo-random sequence.
			\trand.Seed(1)
			}

			// randomFormat returns one of a set of greeting messages. The returned
			// message is selected at random.
			func randomFormat() string {
			\t// A slice of message formats.
			\tformats := []string{
			\t\t"Hi, %v. Welcome!",
			\t\t"Great to see you, %v!",
			\t\t"Hail, %v! Well met!",
			\t}

			\t// Return one of the message formats selected at random.
			\treturn formats[rand.Intn(len(formats))]
			}

			"""
		Target: "/home/gopher/greetings/greetings.go"
	}
	greetings_check_tests_pass: {
		StepType: 1
		Name:     "greetings_check_tests_pass"
		Order:    53
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go test"
			ExitCode: 0
			Output: """
				PASS
				ok  \t{{{.GREETINGS}}}\t0.001s

				"""
		}]
	}
	hello_cd_for_install: {
		StepType: 1
		Name:     "hello_cd_for_install"
		Order:    54
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "cd /home/gopher/hello"
			ExitCode: 0
			Output:   ""
		}]
	}
	hello_go_list_target: {
		StepType: 1
		Name:     "hello_go_list_target"
		Order:    55
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go list -f '{{.Target}}'"
			ExitCode: 0
			Output: """
				/home/gopher/go/bin/hello

				"""
		}]
	}
	hello_add_gopath_bin_path: {
		StepType: 1
		Name:     "hello_add_gopath_bin_path"
		Order:    56
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "goinstalldir=\"$(dirname \"$(go list -f '{{.Target}}')\")\""
			ExitCode: 0
			Output:   ""
		}, {
			CmdStr:   "export PATH=\"$goinstalldir:$PATH\""
			ExitCode: 0
			Output:   ""
		}]
	}
	hello_go_install: {
		StepType: 1
		Name:     "hello_go_install"
		Order:    57
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go install"
			ExitCode: 0
			Output:   ""
		}]
	}
	hello_run_by_name: {
		StepType: 1
		Name:     "hello_run_by_name"
		Order:    58
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "hello"
			ExitCode: 0
			Output: """
				map[Darrin:Hail, Darrin! Well met! Gladys:Hail, Gladys! Well met! Samantha:Hi, Samantha. Welcome!]

				"""
		}]
	}
}
Hash: "9e4f02d46d20499be5e4590c8b6068da3c3a6715ab541822dd296e631cd5b491"
Delims: ["{{{", "}}}"]
