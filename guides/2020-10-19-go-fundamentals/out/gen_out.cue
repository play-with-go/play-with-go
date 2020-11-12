package out

Presteps: [{
	Variables: ["GITEA_USERNAME", "GITEA_PASSWORD", "GREETINGS", "HELLO"]
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
		      "Version": "v0.0.2-0.20201112105706-464aa7e03365",
		      "Sum": "h1:rIO+qeZcanEl9kEkrVEASR1EnjRZFW4cljBwiM7Iq7E=",
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
			Var:     "GREETINGS"
			Private: false
			Pattern: "greetings"
		}, {
			Var:     "HELLO"
			Private: false
			Pattern: "hello"
		}]
	}
	Package: "github.com/play-with-go/gitea"
	Path:    "/newuser"
}]
Terminals: [{
	Description: "The main terminal"
	Scenarios: {
		go115: {
			Image: "playwithgo/go1.15.3@sha256:0212016958cbedb4297dd05407256f3f92dbbac4dd7f5ccf514117e79c6c92d2"
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
	hello_run_by_name: {
		Stmts: [{
			ComparisonOutput: """
				map[Darrin:Hail, Darrin! Well met! Gladys:Hail, Gladys! Well met! Samantha:Hi, Samantha. Welcome!]

				"""
			Output: """
				map[Darrin:Hail, Darrin! Well met! Gladys:Hail, Gladys! Well met! Samantha:Hi, Samantha. Welcome!]

				"""
			ExitCode: 0
			CmdStr:   "hello"
			Negated:  false
		}]
		Order:           55
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "hello_run_by_name"
	}
	hello_go_install: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "go install"
			Negated:          false
		}]
		Order:           54
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "hello_go_install"
	}
	hello_add_gopath_bin_path: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "goinstalldir=\"$(dirname \"$(go list -f '{{.Target}}')\")\""
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "export PATH=\"$goinstalldir:$PATH\""
			Negated:          false
		}]
		Order:           53
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "hello_add_gopath_bin_path"
	}
	hello_go_list_target: {
		Stmts: [{
			ComparisonOutput: """
				/home/gopher/go/bin/hello

				"""
			Output: """
				/home/gopher/go/bin/hello

				"""
			ExitCode: 0
			CmdStr:   "go list -f '{{.Target}}'"
			Negated:  false
		}]
		Order:           52
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "hello_go_list_target"
	}
	hello_cd_for_install: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/hello"
			Negated:          false
		}]
		Order:           51
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "hello_cd_for_install"
	}
	greetings_check_tests_pass: {
		Stmts: [{
			ComparisonOutput: """
				PASS
				ok  \t{{{.GREETINGS}}}\t0.042s

				"""
			Output: """
				PASS
				ok  \t{{{.GREETINGS}}}\t0.042s

				"""
			ExitCode: 0
			CmdStr:   "go test"
			Negated:  false
		}]
		Order:           50
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "greetings_check_tests_pass"
	}
	greetings_go_restore: {
		Order: 49
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
		Renderer: {
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
			RendererType: 3
		}
		Language: "go"
		Target:   "/home/gopher/greetings/greetings.go"
		Terminal: "term1"
		StepType: 2
		Name:     "greetings_go_restore"
	}
	greetings_run_tests_fail: {
		Stmts: [{
			ComparisonOutput: """
				--- FAIL: TestHelloName (0.042s)
				    greetings_test.go:15: Hello("Gladys") = "Hail, %v! Well met!", <nil>, want match for `\\bGladys\\b`, <nil>
				FAIL
				exit status 1
				FAIL\t{{{.GREETINGS}}}\t0.042s

				"""
			Output: """
				--- FAIL: TestHelloName (0.042s)
				    greetings_test.go:15: Hello("Gladys") = "Hail, %v! Well met!", <nil>, want match for `\\bGladys\\b`, <nil>
				FAIL
				exit status 1
				FAIL\t{{{.GREETINGS}}}\t0.042s

				"""
			ExitCode: 1
			CmdStr:   "go test"
			Negated:  true
		}]
		Order:           48
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "greetings_run_tests_fail"
	}
	greetings_go_break: {
		Order: 47
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
		Renderer: {
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
			RendererType: 3
		}
		Language: "go"
		Target:   "/home/gopher/greetings/greetings.go"
		Terminal: "term1"
		StepType: 2
		Name:     "greetings_go_break"
	}
	greetings_run_tests: {
		Stmts: [{
			ComparisonOutput: """
				PASS
				ok  \t{{{.GREETINGS}}}\t0.042s

				"""
			Output: """
				PASS
				ok  \t{{{.GREETINGS}}}\t0.042s

				"""
			ExitCode: 0
			CmdStr:   "go test"
			Negated:  false
		}, {
			ComparisonOutput: """
				=== RUN   TestHelloName
				--- PASS: TestHelloName (0.042s)
				=== RUN   TestHelloEmpty
				--- PASS: TestHelloEmpty (0.042s)
				PASS
				ok  \t{{{.GREETINGS}}}\t0.042s

				"""
			Output: """
				=== RUN   TestHelloName
				--- PASS: TestHelloName (0.042s)
				=== RUN   TestHelloEmpty
				--- PASS: TestHelloEmpty (0.042s)
				PASS
				ok  \t{{{.GREETINGS}}}\t0.042s

				"""
			ExitCode: 0
			CmdStr:   "go test -v"
			Negated:  false
		}]
		Order:           46
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "greetings_run_tests"
	}
	greetings_create_greetings_test_go: {
		Order: 45
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
		Renderer: {
			RendererType: 1
		}
		Language: "go"
		Target:   "/home/gopher/greetings/greetings_test.go"
		Terminal: "term1"
		StepType: 2
		Name:     "greetings_create_greetings_test_go"
	}
	greetings_return_to_write_test: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/greetings"
			Negated:          false
		}]
		Order:           44
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "greetings_return_to_write_test"
	}
	hello_run_multiple: {
		Stmts: [{
			ComparisonOutput: """
				map[Darrin:Hail, Darrin! Well met! Gladys:Hail, Gladys! Well met! Samantha:Hi, Samantha. Welcome!]

				"""
			Output: """
				map[Darrin:Hail, Darrin! Well met! Gladys:Hail, Gladys! Well met! Samantha:Hi, Samantha. Welcome!]

				"""
			ExitCode: 0
			CmdStr:   "go run hello.go"
			Negated:  false
		}]
		Order:           43
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "hello_run_multiple"
	}
	hello_go_call_multiple: {
		Order: 42
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
		Renderer: {
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
			RendererType: 3
		}
		Language: "go"
		Target:   "/home/gopher/hello/hello.go"
		Terminal: "term1"
		StepType: 2
		Name:     "hello_go_call_multiple"
	}
	hello_cat_go_mod_replace: {
		Stmts: [{
			ComparisonOutput: """
				module {{{.HELLO}}}

				go 1.15

				require {{{.GREETINGS}}} v0.0.0-20060102150405-abcedf12345

				replace {{{.GREETINGS}}} => /home/gopher/greetings

				"""
			Output: """
				module {{{.HELLO}}}

				go 1.15

				require {{{.GREETINGS}}} v0.0.0-20060102150405-abcedf12345

				replace {{{.GREETINGS}}} => /home/gopher/greetings

				"""
			ExitCode: 0
			CmdStr:   "cat go.mod"
			Negated:  false
		}]
		Order:           41
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "hello_cat_go_mod_replace"
	}
	hello_replace_greetings: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "go mod edit -replace {{{.GREETINGS}}}=/home/gopher/greetings"
			Negated:          false
		}]
		Order:           40
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "hello_replace_greetings"
	}
	hello_use_multiple: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/hello"
			Negated:          false
		}]
		Order:           39
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "hello_use_multiple"
	}
	greetings_go_multiple_people: {
		Order: 38
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
		Renderer: {
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
			RendererType: 3
		}
		Language: "go"
		Target:   "/home/gopher/greetings/greetings.go"
		Terminal: "term1"
		StepType: 2
		Name:     "greetings_go_multiple_people"
	}
	greetings_start_multiple: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/greetings"
			Negated:          false
		}]
		Order:           37
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "greetings_start_multiple"
	}
	hello_run_random: {
		Stmts: [{
			ComparisonOutput: """
				Hail, Gladys! Well met!

				"""
			Output: """
				Hail, Gladys! Well met!

				"""
			ExitCode: 0
			CmdStr:   "go run hello.go"
			Negated:  false
		}, {
			ComparisonOutput: """
				Hail, Gladys! Well met!

				"""
			Output: """
				Hail, Gladys! Well met!

				"""
			ExitCode: 0
			CmdStr:   "go run hello.go"
			Negated:  false
		}]
		Order:           36
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "hello_run_random"
	}
	hello_go_readd_gladys: {
		Order: 35
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
		Renderer: {
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
			RendererType: 3
		}
		Language: "go"
		Target:   "/home/gopher/hello/hello.go"
		Terminal: "term1"
		StepType: 2
		Name:     "hello_go_readd_gladys"
	}
	hello_golist_random_greetings: {
		Stmts: [{
			ComparisonOutput: """
				v0.0.0-20060102150405-abcedf12345

				"""
			Output: """
				v0.0.0-20060102150405-abcedf12345

				"""
			ExitCode: 0
			CmdStr:   "go list -m -f {{.Version}} {{{.GREETINGS}}}"
			Negated:  false
		}]
		Order:           34
		InformationOnly: true
		DoNotTrim:       false
		RandomReplace:   "v0.0.0-20060102150405-abcedf12345"
		Terminal:        "term1"
		StepType:        1
		Name:            "hello_golist_random_greetings"
	}
	hello_use_random: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/hello"
			Negated:          false
		}, {
			ComparisonOutput: """

				go: downloading {{{.GREETINGS}}} v0.0.0-20060102150405-abcedf12345
				go: {{{.GREETINGS}}} v0.0.0-20060102150405-abcedf12345 => v0.0.0-20060102150405-abcedf12345
				"""
			Output: """
				go: {{{.GREETINGS}}} v0.0.0-20060102150405-abcedf12345 => v0.0.0-20060102150405-abcedf12345
				go: downloading {{{.GREETINGS}}} v0.0.0-20060102150405-abcedf12345

				"""
			ExitCode: 0
			CmdStr:   "go get {{{.GREETINGS}}}@$greetings_random_commit"
			Negated:  false
		}]
		Order:           33
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "hello_use_random"
	}
	greetings_publish_random: {
		Stmts: [{
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
		Order:           32
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "greetings_publish_random"
	}
	greetings_echo_random_commit: {
		Stmts: [{
			ComparisonOutput: """
				v0.0.0-20060102150405-abcedf12345

				"""
			Output: """
				v0.0.0-20060102150405-abcedf12345

				"""
			ExitCode: 0
			CmdStr:   "git rev-parse HEAD"
			Negated:  false
		}]
		Order:           31
		InformationOnly: true
		DoNotTrim:       false
		RandomReplace:   "v0.0.0-20060102150405-abcedf12345"
		Terminal:        "term1"
		StepType:        1
		Name:            "greetings_echo_random_commit"
	}
	greetings_random_commit: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "greetings_random_commit=$(git rev-parse HEAD)"
			Negated:          false
		}]
		Order:           30
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "greetings_random_commit"
	}
	greeings_commit_random: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git add greetings.go"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git commit -q -m 'Added random format'"
			Negated:          false
		}]
		Order:           29
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "greeings_commit_random"
	}
	update_greetings_go_random: {
		Order: 28
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
		Renderer: {
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
			RendererType: 3
		}
		Language: "go"
		Target:   "/home/gopher/greetings/greetings.go"
		Terminal: "term1"
		StepType: 2
		Name:     "update_greetings_go_random"
	}
	cd_greetings_random: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/greetings"
			Negated:          false
		}]
		Order:           27
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "cd_greetings_random"
	}
	run_hello_error: {
		Stmts: [{
			ComparisonOutput: """
				greetings: empty name
				exit status 1

				"""
			Output: """
				greetings: empty name
				exit status 1

				"""
			ExitCode: 1
			CmdStr:   "go run hello.go"
			Negated:  true
		}]
		Order:           26
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "run_hello_error"
	}
	update_hello_go_error: {
		Order: 25
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
		Renderer: {
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
			RendererType: 3
		}
		Language: "go"
		Target:   "/home/gopher/hello/hello.go"
		Terminal: "term1"
		StepType: 2
		Name:     "update_hello_go_error"
	}
	golist_latest_greetings: {
		Stmts: [{
			ComparisonOutput: """
				v0.0.0-20060102150405-abcedf12345

				"""
			Output: """
				v0.0.0-20060102150405-abcedf12345

				"""
			ExitCode: 0
			CmdStr:   "go list -m -f {{.Version}} {{{.GREETINGS}}}"
			Negated:  false
		}]
		Order:           24
		InformationOnly: true
		DoNotTrim:       false
		RandomReplace:   "v0.0.0-20060102150405-abcedf12345"
		Terminal:        "term1"
		StepType:        1
		Name:            "golist_latest_greetings"
	}
	get_latest_greetings: {
		Stmts: [{
			ComparisonOutput: """

				go: downloading {{{.GREETINGS}}} v0.0.0-20060102150405-abcedf12345
				go: {{{.GREETINGS}}} v0.0.0-20060102150405-abcedf12345 => v0.0.0-20060102150405-abcedf12345
				"""
			Output: """
				go: {{{.GREETINGS}}} v0.0.0-20060102150405-abcedf12345 => v0.0.0-20060102150405-abcedf12345
				go: downloading {{{.GREETINGS}}} v0.0.0-20060102150405-abcedf12345

				"""
			ExitCode: 0
			CmdStr:   "go get {{{.GREETINGS}}}@$greetings_error_commit"
			Negated:  false
		}]
		Order:           23
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "get_latest_greetings"
	}
	cd_hello: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/hello"
			Negated:          false
		}]
		Order:           22
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "cd_hello"
	}
	republish_greetings: {
		Stmts: [{
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
		Order:           21
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "republish_greetings"
	}
	echo_greetings_error_commit: {
		Stmts: [{
			ComparisonOutput: """
				v0.0.0-20060102150405-abcedf12345

				"""
			Output: """
				v0.0.0-20060102150405-abcedf12345

				"""
			ExitCode: 0
			CmdStr:   "git rev-parse HEAD"
			Negated:  false
		}]
		Order:           20
		InformationOnly: true
		DoNotTrim:       false
		RandomReplace:   "v0.0.0-20060102150405-abcedf12345"
		Terminal:        "term1"
		StepType:        1
		Name:            "echo_greetings_error_commit"
	}
	greetings_error_commit: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "greetings_error_commit=$(git rev-parse HEAD)"
			Negated:          false
		}]
		Order:           19
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "greetings_error_commit"
	}
	commit_greetings_error_handling: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git add greetings.go"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git commit -q -m 'Added error handling'"
			Negated:          false
		}]
		Order:           18
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "commit_greetings_error_handling"
	}
	update_greetings_go: {
		Order: 17
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
		Renderer: {
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
			RendererType: 3
		}
		Language: "go"
		Target:   "/home/gopher/greetings/greetings.go"
		Terminal: "term1"
		StepType: 2
		Name:     "update_greetings_go"
	}
	cd_greetings: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/greetings"
			Negated:          false
		}]
		Order:           16
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "cd_greetings"
	}
	buildrun_hello: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "go build"
			Negated:          false
		}, {
			ComparisonOutput: """
				Hi, Gladys. Welcome!

				"""
			Output: """
				Hi, Gladys. Welcome!

				"""
			ExitCode: 0
			CmdStr:   "./hello"
			Negated:  false
		}]
		Order:           15
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "buildrun_hello"
	}
	create_hellogo: {
		Order: 14
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
		Renderer: {
			RendererType: 1
		}
		Language: "go"
		Target:   "/home/gopher/hello/hello.go"
		Terminal: "term1"
		StepType: 2
		Name:     "create_hellogo"
	}
	golist_greetings: {
		Stmts: [{
			ComparisonOutput: """
				v0.0.0-20060102150405-abcedf12345

				"""
			Output: """
				v0.0.0-20060102150405-abcedf12345

				"""
			ExitCode: 0
			CmdStr:   "go list -m -f {{.Version}} {{{.GREETINGS}}}"
			Negated:  false
		}]
		Order:           13
		InformationOnly: true
		DoNotTrim:       false
		RandomReplace:   "v0.0.0-20060102150405-abcedf12345"
		Terminal:        "term1"
		StepType:        1
		Name:            "golist_greetings"
	}
	goget_greetings: {
		Stmts: [{
			ComparisonOutput: """

				go: downloading {{{.GREETINGS}}} v0.0.0-20060102150405-abcedf12345
				go: {{{.GREETINGS}}} upgrade => v0.0.0-20060102150405-abcedf12345
				"""
			Output: """
				go: downloading {{{.GREETINGS}}} v0.0.0-20060102150405-abcedf12345
				go: {{{.GREETINGS}}} upgrade => v0.0.0-20060102150405-abcedf12345

				"""
			ExitCode: 0
			CmdStr:   "go get {{{.GREETINGS}}}"
			Negated:  false
		}]
		Order:           12
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "goget_greetings"
	}
	gomodinit_hello: {
		Stmts: [{
			ComparisonOutput: """
				go: creating new go.mod: module {{{.HELLO}}}

				"""
			Output: """
				go: creating new go.mod: module {{{.HELLO}}}

				"""
			ExitCode: 0
			CmdStr:   "go mod init {{{.HELLO}}}"
			Negated:  false
		}]
		Order:           11
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gomodinit_hello"
	}
	mkdir_hello: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "mkdir /home/gopher/hello"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/hello"
			Negated:          false
		}]
		Order:           10
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "mkdir_hello"
	}
	greetings_gitpush: {
		Stmts: [{
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
		Order:           9
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "greetings_gitpush"
	}
	greetings_gitadd: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git add greetings.go"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git commit -q -m 'Initial commit'"
			Negated:          false
		}]
		Order:           8
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "greetings_gitadd"
	}
	greetings_gitinit: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git init -q"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "git remote add origin https://{{{.GREETINGS}}}.git"
			Negated:          false
		}]
		Order:           7
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "greetings_gitinit"
	}
	create_greetingsgo_long: {
		Order: 6
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
		Renderer: {
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
			RendererType: 3
		}
		Language: "go"
		Target:   "/home/gopher/greetings/greetings.go"
		Terminal: "term1"
		StepType: 2
		Name:     "create_greetingsgo_long"
	}
	create_greetingsgo: {
		Order: 5
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
		Renderer: {
			RendererType: 1
		}
		Language: "go"
		Target:   "/home/gopher/greetings/greetings.go"
		Terminal: "term1"
		StepType: 2
		Name:     "create_greetingsgo"
	}
	cat_gomodgreetings: {
		Stmts: [{
			ComparisonOutput: """
				module {{{.GREETINGS}}}

				go 1.15

				"""
			Output: """
				module {{{.GREETINGS}}}

				go 1.15

				"""
			ExitCode: 0
			CmdStr:   "cat go.mod"
			Negated:  false
		}]
		Order:           4
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "cat_gomodgreetings"
	}
	gomodinit_greetings: {
		Stmts: [{
			ComparisonOutput: """
				go: creating new go.mod: module {{{.GREETINGS}}}

				"""
			Output: """
				go: creating new go.mod: module {{{.GREETINGS}}}

				"""
			ExitCode: 0
			CmdStr:   "go mod init {{{.GREETINGS}}}"
			Negated:  false
		}]
		Order:           3
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gomodinit_greetings"
	}
	mkdir_greetings: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "mkdir /home/gopher/greetings"
			Negated:          false
		}, {
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "cd /home/gopher/greetings"
			Negated:          false
		}]
		Order:           2
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "mkdir_greetings"
	}
	pwd_home: {
		Stmts: [{
			ComparisonOutput: """
				/home/gopher

				"""
			Output: """
				/home/gopher

				"""
			ExitCode: 0
			CmdStr:   "pwd"
			Negated:  false
		}]
		Order:           1
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "pwd_home"
	}
	goversion: {
		Stmts: [{
			ComparisonOutput: """
				go version go1.15.3 linux/amd64

				"""
			Output: """
				go version go1.15.3 linux/amd64

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
Hash: "17fe96bddae374019fde3b8f75686ef50d439c61f93d871797da70b3a35d847d"
Delims: ["{{{", "}}}"]
