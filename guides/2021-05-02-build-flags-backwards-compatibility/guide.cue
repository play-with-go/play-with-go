package guide

import (
	"github.com/play-with-go/gitea"
	"github.com/play-with-go/preguide"
)

Presteps: [gitea.#PrestepNewUser & {
	Args: {
		Repos: [
			{Var: "PUBLIC", Pattern: "public"},
		]
	}
}]

Defs: {
	_#commonDefs
	go115:              "go115"
	go116:              "go116"
	public:             "public"
	public_vcs:         "https://\(public_mod).git"
	public_mod:         "{{{.PUBLIC}}}"
	public_dir:         "/home/gopher/\(public)"
	public_go:          "\(public).go"
	public_go116:       "\(public)_116.go"
	public_func:        "DoSomething()"
	gopher:             "gopher"
	gopher_vcs:         "https://\(gopher_mod).git"
	gopher_mod:         gopher
	gopher_dir:         "/home/gopher/\(gopher)"
	gopher_go:          "\(gopher).go"
	go_help_env:        "\(_#commonDefs.cmdgo.help) env"
	go_help_modprivate: "\(_#commonDefs.cmdgo.help) module-private"
}

Scenarios: go115: preguide.#Scenario & {
	Description: "Go 1.15"
}

Terminals: term1: preguide.#Terminal & {
	Description: "The main terminal"
	Scenarios: go115: Image: "lala"
}

Steps: go115version: preguide.#Command & {
	Source: """
		\(Defs.go115) version
		"""
}

Steps: go116version: preguide.#Command & {
	Source: """
		\(Defs.go116) version
		"""
}

Steps: go115default: preguide.#Command & {
	Source: """
		alias go=\(Defs.go115) 
		"""
}

Steps: public_init: preguide.#Command & {
	Source: """
		mkdir \(Defs.public_dir)
		cd \(Defs.public_dir)
		\(Defs.cmdgo.modinit) \(Defs.public_mod)
		\(Defs.git.init)
		\(Defs.git.remote) add origin \(Defs.public_vcs)
		"""
}

Steps: public_go_initial: preguide.#Upload & {
	Target: "\(Defs.public_dir)/\(Defs.public_go)"
	Source: #"""
package \#(Defs.public)

import (
    "fmt"
    "io/ioutil"
)

func \#(Defs.public_func) {
    fmt.Fprintf(ioutil.Discard, "This doesn't print anything")
}
"""#
}

Steps: public_initial_commit: preguide.#Command & {
	Source: """
\(Defs.git.add) \(Defs.public_go) go.mod
\(Defs.git.commit) -m 'Initial commit of \(Defs.public) module'
\(Defs.git.push) origin main
"""
}

Steps: public_check_initial_porcelain: preguide.#Command & {
	InformationOnly: true
	Source: """
		[ "$(git status --porcelain)" == "" ] || (git status && false)
		"""
}

Steps: gopher_init: preguide.#Command & {
	Source: """
mkdir \(Defs.gopher_dir)
cd \(Defs.gopher_dir)
\(Defs.cmdgo.modinit) \(Defs.gopher)
"""
}

Steps: gopher_go_initial: preguide.#Upload & {
	Target: "\(Defs.gopher_dir)/\(Defs.gopher_go)"
	Source: #"""
package main

import (

"\#(Defs.public_mod)"
)

func main() {
    \#(Defs.public).\#(Defs.public_func)
}

"""#
}

Steps: gopher_run: preguide.#Command & {
	Source: """
\(Defs.cmdgo.run) .
"""
}

Steps: go116default: preguide.#Command & {
	Source: """
alias go=\(Defs.go116) 
"""
}

Steps: public_bump_discard: preguide.#Upload & {
	Target: "\(Defs.public_dir)/\(Defs.public_go)"
	Source: #"""
package \#(Defs.public)

import (
    "fmt"
    "io"
)

func \#(Defs.public_func) {
    fmt.Fprintf(io.Discard, "This doesn't print anything")
}
"""#
}

Steps: public_bump_commit: preguide.#Command & {
	Source: """
cd \(Defs.public_dir)
\(Defs.git.checkout) -b bump
\(Defs.git.add) \(Defs.public_go) go.mod
\(Defs.git.commit) -m 'Bump \(Defs.public) to go1.16'
\(Defs.git.push) origin bump
"""
}

Steps: go115default1: preguide.#Command & {
	Source: """
		alias go=\(Defs.go115) 
		"""
}

Steps: gopher_update_fail: preguide.#Command & {
	Source: """
cd \(Defs.gopher_dir)
# We launch this in a subshell to assert the status code
code=$(\(Defs.cmdgo.get) -u -v \(Defs.public_mod)@bump; echo $?)

# Assert that status code is correct or fail
[ $code == 2 ] || false
"""
}

Steps: public_rollback_mod: preguide.#Upload & {
	Target: "\(Defs.public_dir)/\(Defs.public_go)"
	Source: #"""
// +build !go1.16

package \#(Defs.public)

import (
    "fmt"
    "io/ioutil"
)

func \#(Defs.public_func) {
    fmt.Fprintf(ioutil.Discard, "This doesn't print anything")
}
"""#
}

Steps: public_add_buildtag: preguide.#Upload & {
	Target: "\(Defs.public_dir)/\(Defs.public_go116)"
	Source: #"""
// +build go.1.16

package \#(Defs.public)

import (
    "fmt"
    "io"
)

func \#(Defs.public_func) {
    fmt.Fprintf(io.Discard, "This doesn't print anything")
}
"""#
}

Steps: public_fix_commit: preguide.#Command & {
	Source: """
cd \(Defs.public_dir)
\(Defs.git.checkout) -b bump_fix
\(Defs.git.add) \(Defs.public_go) \(Defs.public_go116) go.mod
\(Defs.git.commit) -m 'Fix \(Defs.public) bump to go1.16'
\(Defs.git.push) origin bump_fix
"""
}

Steps: gopher_update_ok: preguide.#Command & {
	Source: """
cd \(Defs.gopher_dir)
\(Defs.cmdgo.get) -d -v \(Defs.public_mod)@bump_fix
"""
}
