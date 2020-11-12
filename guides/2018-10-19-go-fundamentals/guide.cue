package guide

import (
	"github.com/play-with-go/gitea"
	"github.com/play-with-go/preguide"
)

Presteps: [gitea.#PrestepNewUser & {
	Args: {
		Repos: [
			{Var: "GREETINGS", Pattern: "greetings"},
			{Var: "HELLO", Pattern:     "hello"},
		]
	}
}]

Defs: {
	_#commonDefs
	greetings:           "greetings"
	greetings_vcs:       "https://\(greetings_mod).git"
	greetings_mod:       "{{{.GREETINGS}}}"
	greetings_dir:       "/home/gopher/\(greetings)"
	greetings_go:        "\(greetings).go"
	greetings_test_go:   "\(greetings)_test.go"
	hello:               "hello"
	hello_vcs:           "https://\(hello_mod).git"
	hello_mod:           "{{{.HELLO}}}"
	hello_dir:           "/home/gopher/\(hello)"
	hello_go:            "\(hello).go"
	greeting_log_prefix: "greetings: "
}

Scenarios: go115: preguide.#Scenario & {
	Description: "Go 1.15"
}

Terminals: term1: preguide.#Terminal & {
	Description: "The main terminal"
	Scenarios: go115: Image: _#go115LatestImage
}

Steps: goversion: preguide.#Command & {
	Source: """
		go version
		"""
}

Steps: pwd_home: preguide.#Command & {
	Source: """
		pwd
		"""
}

Steps: mkdir_greetings: preguide.#Command & {
	Source: """
		mkdir \(Defs.greetings_dir)
		cd \(Defs.greetings_dir)
		"""
}

Steps: gomodinit_greetings: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.modinit) \(Defs.greetings_mod)
		"""
}

Steps: cat_gomodgreetings: preguide.#Command & {
	Source: """
		cat go.mod
		"""
}

Steps: create_greetingsgo: preguide.#Upload & {
	Target: "\(Defs.greetings_dir)/\(Defs.greetings_go)"
	Source: """
		package greetings

		import "fmt"

		// Hello returns a greeting for the named person.
		func Hello(name string) string {
			// Return a greeting that embeds the name in a message.
			message := fmt.Sprintf("Hi, %v. Welcome!", name)
			return message
		}

		"""
}

Steps: create_greetingsgo_long: preguide.#Upload & {
	Target:   "\(Defs.greetings_dir)/\(Defs.greetings_go)"
	Renderer: preguide.#RenderDiff & {Pre: Steps.create_greetingsgo.Source}
	Source: """
		package greetings

		import "fmt"

		// Hello returns a greeting for the named person.
		func Hello(name string) string {
			// Return a greeting that embeds the name in a message.
			var message string
			message = fmt.Sprintf("Hi, %v. Welcome!", name)
			return message
		}

		"""
}

Steps: greetings_gitinit: preguide.#Command & {
	Source: """
		\(Defs.git.init)
		\(Defs.git.remote) add origin \(Defs.greetings_vcs)
		"""
}

Steps: greetings_gitadd: preguide.#Command & {
	Source: """
		\(Defs.git.add) \(Defs.greetings_go)
		\(Defs.git.commit) -m 'Initial commit'
		"""
}

Steps: greetings_gitpush: preguide.#Command & {
	Source: """
		\(Defs.git.push) origin main
		"""
}

Steps: mkdir_hello: preguide.#Command & {
	Source: """
		mkdir \(Defs.hello_dir)
		cd \(Defs.hello_dir)
		"""
}

Steps: gomodinit_hello: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.modinit) \(Defs.hello_mod)
		"""
}

Steps: goget_greetings: preguide.#Command & {
	Source: """
		go get \(Defs.greetings_mod)
		"""
}

Steps: golist_greetings: preguide.#Command & {
	InformationOnly: true
	RandomReplace:   "v0.0.0-\(_#StablePsuedoversionSuffix)"
	Source:          """
		go list -m -f {{.Version}} \(Defs.greetings_mod)
		"""
}

Steps: create_hellogo: preguide.#Upload & {
	Target: "\(Defs.hello_dir)/\(Defs.hello_go)"
	Source: """
		package main

		import (
			"fmt"

			"\(Defs.greetings_mod)"
		)

		func main() {
			// Get a greeting message and print it.
			message := greetings.Hello("Gladys")
			fmt.Println(message)
		}

		"""
}

Steps: buildrun_hello: preguide.#Command & {
	Source: """
		go build
		./hello
		"""
}

Steps: cd_greetings: preguide.#Command & {
	Source: """
		cd \(Defs.greetings_dir)
		"""
}

Steps: update_greetings_go: preguide.#Upload & {
	Target:   "\(Defs.greetings_dir)/\(Defs.greetings_go)"
	Renderer: preguide.#RenderDiff & {Pre: Steps.create_greetingsgo_long.Source}
	Source: """
		package greetings

		import (
			"errors"
			"fmt"
		)

		// Hello returns a greeting for the named person.
		func Hello(name string) (string, error) {
			// If no name was given, return an error with a message.
			if name == "" {
				return "", errors.New("empty name")
			}

			// If a name was received, return a value that embeds the name
			// in a greeting message.
			message := fmt.Sprintf("Hi, %v. Welcome!", name)
			return message, nil
		}

		"""
}

Steps: commit_greetings_error_handling: preguide.#Command & {
	Source: """
		\(Defs.git.add) \(Defs.greetings_go)
		\(Defs.git.commit) -m 'Added error handling'
		"""
}

Steps: greetings_error_commit: preguide.#Command & {
	Source: """
		greetings_error_commit=$(\(Defs.git.revparse) HEAD)
		"""
}

Steps: echo_greetings_error_commit: preguide.#Command & {
	InformationOnly: true
	RandomReplace:   "v0.0.0-\(_#StablePsuedoversionSuffix)"
	Source:          """
		\(Defs.git.revparse) HEAD
		"""
}

Steps: republish_greetings: preguide.#Command & {
	Source: """
		\(Defs.git.push) origin main
		"""
}

Steps: cd_hello: preguide.#Command & {
	Source: """
		cd \(Defs.hello_dir)
		"""
}

Steps: get_latest_greetings: preguide.#Command & {
	Source: """
		go get \(Defs.greetings_mod)@$greetings_error_commit
		"""
}

Steps: golist_latest_greetings: preguide.#Command & {
	InformationOnly: true
	RandomReplace:   "v0.0.0-\(_#StablePsuedoversionSuffix)"
	Source:          """
		go list -m -f {{.Version}} \(Defs.greetings_mod)
		"""
}

Steps: update_hello_go_error: preguide.#Upload & {
	Target:   "\(Defs.hello_dir)/\(Defs.hello_go)"
	Renderer: preguide.#RenderDiff & {Pre: Steps.create_hellogo.Source}
	Source:   """
		package main

		import (
			"fmt"
			"log"

			"\(Defs.greetings_mod)"
		)

		func main() {
			// Set properties of the predefined Logger, including
			// the log entry prefix and a flag to disable printing
			// the time, source file, and line number.
			log.SetPrefix("\(Defs.greeting_log_prefix)")
			log.SetFlags(0)

			// Request a greeting message.
			message, err := greetings.Hello("")
			// If an error was returned, print it to the console and
			// exit the program.
			if err != nil {
				log.Fatal(err)
			}

			// If no error was returned, print the returned message
			// to the console.
			fmt.Println(message)
		}

		"""
}

Steps: run_hello_error: preguide.#Command & {
	Source: """
		! \(Defs.cmdgo.run) hello.go
		"""
}

Steps: cd_greetings_random: preguide.#Command & {
	Source: """
		cd \(Defs.greetings_dir)
		"""
}

Steps: update_greetings_go_random: preguide.#Upload & {
	Target:   "\(Defs.greetings_dir)/\(Defs.greetings_go)"
	Renderer: preguide.#RenderDiff & {Pre: Steps.create_greetingsgo.Source}
	Source: """
		package greetings

		import (
			"errors"
			"fmt"
			"math/rand"
		)

		// Hello returns a greeting for the named person.
		func Hello(name string) (string, error) {
			// If no name was given, return an error with a message.
			if name == "" {
				return name, errors.New("empty name")
			}
			// Create a message using a random format.
			message := fmt.Sprintf(randomFormat(), name)
			return message, nil
		}

		// init sets initial values for variables used in the function.
		func init() {
			// For truly random greetings, import "time" and replace the call
			// to rand.Seed with:
			//
			// rand.Seed(time.Now().UnixNano())
			//
			// Calling rand.Seed with a constant value means that we always
			// generate the same pseudo-random sequence.
			rand.Seed(1)
		}

		// randomFormat returns one of a set of greeting messages. The returned
		// message is selected at random.
		func randomFormat() string {
			// A slice of message formats.
			formats := []string{
				"Hi, %v. Welcome!",
				"Great to see you, %v!",
				"Hail, %v! Well met!",
			}

			// Return one of the message formats selected at random.
			return formats[rand.Intn(len(formats))]
		}

		"""
}

Steps: greeings_commit_random: preguide.#Command & {
	Source: """
		\(Defs.git.add) \(Defs.greetings_go)
		\(Defs.git.commit) -m 'Added random format'
		"""
}

Steps: greetings_random_commit: preguide.#Command & {
	Source: """
		greetings_random_commit=$(\(Defs.git.revparse) HEAD)
		"""
}

Steps: greetings_echo_random_commit: preguide.#Command & {
	InformationOnly: true
	RandomReplace:   "v0.0.0-\(_#StablePsuedoversionSuffix)"
	Source:          """
		\(Defs.git.revparse) HEAD
		"""
}

Steps: greetings_publish_random: preguide.#Command & {
	Source: """
		\(Defs.git.push) origin main
		"""
}

Steps: hello_use_random: preguide.#Command & {
	Source: """
		cd \(Defs.hello_dir)
		\(Defs.cmdgo.get) \(Defs.greetings_mod)@$greetings_random_commit
		"""
}

Steps: hello_golist_random_greetings: preguide.#Command & {
	InformationOnly: true
	RandomReplace:   "v0.0.0-\(_#StablePsuedoversionSuffix)"
	Source:          """
		\(Defs.cmdgo.list) -m -f {{.Version}} \(Defs.greetings_mod)
		"""
}

Steps: hello_go_readd_gladys: preguide.#Upload & {
	Target:   "\(Defs.hello_dir)/\(Defs.hello_go)"
	Renderer: preguide.#RenderDiff & {Pre: Steps.update_hello_go_error.Source}
	Source:   """
		package main

		import (
			"fmt"
			"log"

			"\(Defs.greetings_mod)"
		)

		func main() {
			// Set properties of the predefined Logger, including
			// the log entry prefix and a flag to disable printing
			// the time, source file, and line number.
			log.SetPrefix("\(Defs.greeting_log_prefix)")
			log.SetFlags(0)

			// Request a greeting message.
			message, err := greetings.Hello("Gladys")
			// If an error was returned, print it to the console and
			// exit the program.
			if err != nil {
				log.Fatal(err)
			}

			// If no error was returned, print the returned message
			// to the console.
			fmt.Println(message)
		}

		"""
}

Steps: hello_run_random: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.run) hello.go
		\(Defs.cmdgo.run) hello.go
		"""
}

Steps: greetings_start_multiple: preguide.#Command & {
	Source: """
		cd \(Defs.greetings_dir)
		"""
}

Steps: greetings_go_multiple_people: preguide.#Upload & {
	Target:   "\(Defs.greetings_dir)/\(Defs.greetings_go)"
	Renderer: preguide.#RenderDiff & {Pre: Steps.update_greetings_go_random.Source}
	Source: """
		package greetings

		import (
			"errors"
			"fmt"
			"math/rand"
		)

		// Hello returns a greeting for the named person.
		func Hello(name string) (string, error) {
			// If no name was given, return an error with a message.
			if name == "" {
				return name, errors.New("empty name")
			}
			// Create a message using a random format.
			message := fmt.Sprintf(randomFormat(), name)
			return message, nil
		}

		// Hellos returns a map that associates each of the named people
		// with a greeting message.
		func Hellos(names []string) (map[string]string, error) {
			// A map to associate names with messages.
			messages := make(map[string]string)
			// Loop through the received slice of names, calling
			// the Hello function to get a message for each name.
			for _, name := range names {
				message, err := Hello(name)
				if err != nil {
					return nil, err
				}
				// In the map, associate the retrieved message with
				// the name.
				messages[name] = message
			}
			return messages, nil
		}

		// init sets initial values for variables used in the function.
		func init() {
			// For truly random greetings, import "time" and replace the call
			// to rand.Seed with:
			//
			// rand.Seed(time.Now().UnixNano())
			//
			// Calling rand.Seed with a constant value means that we always
			// generate the same pseudo-random sequence.
			rand.Seed(1)
		}

		// randomFormat returns one of a set of greeting messages. The returned
		// message is selected at random.
		func randomFormat() string {
			// A slice of message formats.
			formats := []string{
				"Hi, %v. Welcome!",
				"Great to see you, %v!",
				"Hail, %v! Well met!",
			}

			// Return one of the message formats selected at random.
			return formats[rand.Intn(len(formats))]
		}

		"""
}

Steps: hello_use_multiple: preguide.#Command & {
	Source: """
		cd \(Defs.hello_dir)
		"""
}

Steps: hello_replace_greetings: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.modedit) -replace \(Defs.greetings_mod)=\(Defs.greetings_dir)
		"""
}

Steps: hello_cat_go_mod_replace: preguide.#Command & {
	Source: """
		cat go.mod
		"""
}

Steps: hello_go_call_multiple: preguide.#Upload & {
	Target:   "\(Defs.hello_dir)/\(Defs.hello_go)"
	Renderer: preguide.#RenderDiff & {Pre: Steps.hello_go_readd_gladys.Source}
	Source:   """
		package main

		import (
			"fmt"
			"log"

			"\(Defs.greetings_mod)"
		)

		func main() {
			// Set properties of the predefined Logger, including
			// the log entry prefix and a flag to disable printing
			// the time, source file, and line number.
			log.SetPrefix("greetings: ")
			log.SetFlags(0)

			// A slice of names.
			names := []string{"Gladys", "Samantha", "Darrin"}

			// Request greeting messages for the names.
			messages, err := greetings.Hellos(names)
			if err != nil {
				log.Fatal(err)
			}
			// If no error was returned, print the returned map of
			// messages to the console.
			fmt.Println(messages)
		}

		"""
}

Steps: hello_run_multiple: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.run) hello.go
		"""
}

Steps: greetings_return_to_write_test: preguide.#Command & {
	Source: """
		cd \(Defs.greetings_dir)
		"""
}

Steps: greetings_create_greetings_test_go: preguide.#Upload & {
	Target: "\(Defs.greetings_dir)/\(Defs.greetings_test_go)"
	Source: #"""
		package greetings

		import (
			"regexp"
			"testing"
		)

		// TestHelloName calls greetings.Hello with a name, checking
		// for a valid return value.
		func TestHelloName(t *testing.T) {
			name := "Gladys"
			want := regexp.MustCompile(`\b` + name + `\b`)
			msg, err := Hello(name)
			if !want.MatchString(msg) || err != nil {
				t.Fatalf(`Hello("Gladys") = %q, %v, want match for %#q, <nil>`, msg, err, want)
			}
		}

		// TestHelloEmpty calls greetings.Hello with an empty string,
		// checking for an error.
		func TestHelloEmpty(t *testing.T) {
			msg, err := Hello("")
			if msg != "" || err == nil {
				t.Fatalf(`Hello("") = %q, %v, want "", error`, msg, err)
			}
		}

		"""#
}

Steps: greetings_run_tests: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.test)
		\(Defs.cmdgo.test) -v
		"""
}

Steps: greetings_go_break: preguide.#Upload & {
	Target:   "\(Defs.greetings_dir)/\(Defs.greetings_go)"
	Renderer: preguide.#RenderDiff & {Pre: Steps.greetings_go_multiple_people.Source}
	Source: """
		package greetings

		import (
			"errors"
			"fmt"
			"math/rand"
		)

		// Hello returns a greeting for the named person.
		func Hello(name string) (string, error) {
			// If no name was given, return an error with a message.
			if name == "" {
				return name, errors.New("empty name")
			}
			// Create a message using a random format.
			// message := fmt.Sprintf(randomFormat(), name)
			message := fmt.Sprint(randomFormat())
			return message, nil
		}

		// Hellos returns a map that associates each of the named people
		// with a greeting message.
		func Hellos(names []string) (map[string]string, error) {
			// A map to associate names with messages.
			messages := make(map[string]string)
			// Loop through the received slice of names, calling
			// the Hello function to get a message for each name.
			for _, name := range names {
				message, err := Hello(name)
				if err != nil {
					return nil, err
				}
				// In the map, associate the retrieved message with
				// the name.
				messages[name] = message
			}
			return messages, nil
		}

		// init sets initial values for variables used in the function.
		func init() {
			// For truly random greetings, import "time" and replace the call
			// to rand.Seed with:
			//
			// rand.Seed(time.Now().UnixNano())
			//
			// Calling rand.Seed with a constant value means that we always
			// generate the same pseudo-random sequence.
			rand.Seed(1)
		}

		// randomFormat returns one of a set of greeting messages. The returned
		// message is selected at random.
		func randomFormat() string {
			// A slice of message formats.
			formats := []string{
				"Hi, %v. Welcome!",
				"Great to see you, %v!",
				"Hail, %v! Well met!",
			}

			// Return one of the message formats selected at random.
			return formats[rand.Intn(len(formats))]
		}

		"""
}

Steps: greetings_run_tests_fail: preguide.#Command & {
	Source: """
		! \(Defs.cmdgo.test)
		"""
}

Steps: greetings_go_restore: preguide.#Upload & {
	Target:   "\(Defs.greetings_dir)/\(Defs.greetings_go)"
	Renderer: preguide.#RenderDiff & {Pre: Steps.greetings_go_break.Source}
	Source: """
		package greetings

		import (
			"errors"
			"fmt"
			"math/rand"
		)

		// Hello returns a greeting for the named person.
		func Hello(name string) (string, error) {
			// If no name was given, return an error with a message.
			if name == "" {
				return name, errors.New("empty name")
			}
			// Create a message using a random format.
			message := fmt.Sprintf(randomFormat(), name)
			return message, nil
		}

		// Hellos returns a map that associates each of the named people
		// with a greeting message.
		func Hellos(names []string) (map[string]string, error) {
			// A map to associate names with messages.
			messages := make(map[string]string)
			// Loop through the received slice of names, calling
			// the Hello function to get a message for each name.
			for _, name := range names {
				message, err := Hello(name)
				if err != nil {
					return nil, err
				}
				// In the map, associate the retrieved message with
				// the name.
				messages[name] = message
			}
			return messages, nil
		}

		// init sets initial values for variables used in the function.
		func init() {
			// For truly random greetings, import "time" and replace the call
			// to rand.Seed with:
			//
			// rand.Seed(time.Now().UnixNano())
			//
			// Calling rand.Seed with a constant value means that we always
			// generate the same pseudo-random sequence.
			rand.Seed(1)
		}

		// randomFormat returns one of a set of greeting messages. The returned
		// message is selected at random.
		func randomFormat() string {
			// A slice of message formats.
			formats := []string{
				"Hi, %v. Welcome!",
				"Great to see you, %v!",
				"Hail, %v! Well met!",
			}

			// Return one of the message formats selected at random.
			return formats[rand.Intn(len(formats))]
		}

		"""
}

Steps: greetings_check_tests_pass: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.test)
		"""
}

Steps: hello_cd_for_install: preguide.#Command & {
	Source: """
		cd \(Defs.hello_dir)
		"""
}

Steps: hello_go_list_target: preguide.#Command & {
	Source: """
		go list -f '{{.Target}}'
		"""
}

Steps: hello_add_gopath_bin_path: preguide.#Command & {
	Source: """
		goinstalldir="$(dirname "$(go list -f '{{.Target}}')")"
		export PATH="$goinstalldir:$PATH"
		"""
}

Steps: hello_go_install: preguide.#Command & {
	Source: """
		go install
		"""
}

Steps: hello_run_by_name: preguide.#Command & {
	Source: """
		hello
		"""
}
