package guide

import (
	"github.com/play-with-go/gitea"
	"github.com/play-with-go/preguide"
)

Presteps: [gitea.#PrestepNewUser & {
	Args: {
		Repos: [
			{Var: "PUBLIC", Pattern:  "public"},
			{Var: "PRIVATE", Pattern: "private", Private: true},
		]
	}
}]

Defs: {
	_#commonDefs
	public:             "public"
	public_vcs:         "https://\(public_mod).git"
	public_mod:         "{{{.PUBLIC}}}"
	public_dir:         "/home/gopher/\(public)"
	public_go:          "\(public).go"
	public_message:     "Message()"
	private:            "private"
	private_vcs:        "https://\(private_mod).git"
	private_mod:        "{{{.PRIVATE}}}"
	private_dir:        "/home/gopher/\(private)"
	private_go:         "\(private).go"
	private_secret:     "Secret()"
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
	Scenarios: go115: Image: _#go115LatestImage
}

Steps: goversion: preguide.#Command & {
	Source: """
		go version
		"""
}

Steps: public_init: preguide.#Command & {
	Source: """
		mkdir \(Defs.public_dir)
		cd \(Defs.public_dir)
		\(Defs.cmdgo.modinit) \(Defs.public)
		\(Defs.git.init)
		\(Defs.git.remote) add origin \(Defs.public_vcs)
		"""
}

Steps: public_go_initial: preguide.#Upload & {
	Target: "\(Defs.public_dir)/\(Defs.public_go)"
	Source: #"""
		package \#(Defs.public)

		func \#(Defs.public_message) string {
			return "This is a public safety announcement!"
		}

		"""#
}

Steps: public_initial_commit: preguide.#Command & {
	Source: """
		\(Defs.git.add) \(Defs.public_go)
		\(Defs.git.commit) -m 'Initial commit of \(Defs.public) module'
		\(Defs.git.push) origin main
		"""
}

Steps: private_init: preguide.#Command & {
	Source: """
		mkdir \(Defs.private_dir)
		cd \(Defs.private_dir)
		\(Defs.cmdgo.modinit) \(Defs.private)
		\(Defs.git.init)
		\(Defs.git.remote) add origin \(Defs.private_vcs)
		"""
}

Steps: private_go_initial: preguide.#Upload & {
	Target: "\(Defs.private_dir)/\(Defs.private_go)"
	Source: #"""
		package \#(Defs.private)

		func \#(Defs.private_secret) string {
			return "This is a top secret message... for your eyes only"
		}

		"""#
}

Steps: private_initial_commit: preguide.#Command & {
	Source: """
		\(Defs.git.add) \(Defs.private_go)
		\(Defs.git.commit) -m 'Initial commit of \(Defs.private) module'
		\(Defs.git.push) origin main
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
			"fmt"

			"\#(Defs.public_mod)"
			"\#(Defs.private_mod)"
		)

		func main() {
			fmt.Printf("\#(Defs.public).\#(Defs.public_message): %v\n", \#(Defs.public).\#(Defs.public_message))
			fmt.Printf("\#(Defs.private).\#(Defs.private_secret): %v\n", \#(Defs.private).\#(Defs.private_secret))
		}

		"""#
}

Steps: go_env_check_goproxy: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.env) GOPROXY
		"""
}

Steps: go_env_check_gosumdb: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.env) GOSUMDB
		"""
}

Steps: go_env_check: preguide.#Command & {
	InformationOnly: true
	Source:          """
		\(Defs.go_help_env)
		"""
}

Steps: goproxy_proxy_only: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.env) -w GOPROXY=https://proxy.golang.org
		"""
}

Steps: gopher_get_public_initial: preguide.#Command & {
	Source: """
		 \(Defs.cmdgo.get) \(Defs.public_mod)
		"""
}

Steps: gopher_get_private_initial: preguide.#Command & {
	Source: """
		! \(Defs.cmdgo.get) \(Defs.private_mod)
		"""
}

Steps: goproxy_proxy_default: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.env) -w GOPROXY=
		"""
}

Steps: gopher_get_private_direct: preguide.#Command & {
	Source: """
		! \(Defs.cmdgo.get) \(Defs.private_mod)
		"""
}

Steps: go_help_modprivate: preguide.#Command & {
	InformationOnly: true
	Source:          """
		\(Defs.go_help_modprivate)
		"""
}

Steps: goprivate_set_private: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.env) -w GOPRIVATE=\(Defs.private_mod)
		"""
}

Steps: gopher_get_private_goprivate: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.get) \(Defs.private_mod)
		"""
}

Steps: gopher_run: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.run) .
		"""
}
