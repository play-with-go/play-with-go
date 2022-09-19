package guide

import (
	"github.com/play-with-go/gitea"
	"github.com/play-with-go/preguide"
)

Presteps: [gitea.#PrestepNewUser & {
	Args: {
		Repos: [
			{Var: "BRANCH", Pattern: "branch"},
			{Var: "SUBDIR", Pattern: "subdir"},
		]
	}
}]

Defs: {
	_#commonDefs
	branch:            "branch"
	branch_vcs:        "https://\(branch_mod).git"
	branch_mod:        "{{{.BRANCH}}}"
	branch_dir:        "/home/gopher/\(branch)"
	branch_go:         "\(branch).go"
	subdir:            "subdir"
	subdir_vcs:        "https://\(subdir_mod).git"
	subdir_mod:        "{{{.SUBDIR}}}"
	subdir_dir:        "/home/gopher/\(subdir)"
	subdir_go:         "\(subdir).go"
	gopher:            "gopher"
	gopher_vcs:        "https://\(gopher_mod).git"
	gopher_mod:        gopher
	gopher_dir:        "/home/gopher/\(gopher)"
	gopher_go:         "\(gopher).go"
	go_help_env:       "\(_#commonDefs.cmdgo.help) env"
	go_help_modsubdir: "\(_#commonDefs.cmdgo.help) module-subdir"
}

Scenarios: go119: preguide.#Scenario & {
	Description: "Go 1.15"
}

Terminals: term1: preguide.#Terminal & {
	Description: "The main terminal"
	Scenarios: go119: Image: _#go119LatestImage
}

Steps: goversion: preguide.#Command & {
	Source: """
		go version
		"""
}

Steps: branch_init: preguide.#Command & {
	Source: """
		mkdir \(Defs.branch_dir)
		cd \(Defs.branch_dir)
		\(Defs.cmdgo.modinit) \(Defs.branch_mod)
		\(Defs.git.init)
		\(Defs.git.remote) add origin \(Defs.branch_vcs)
		"""
}

Steps: branch_go_initial: preguide.#Upload & {
	Target: "\(Defs.branch_dir)/\(Defs.branch_go)"
	Source: #"""
		// \#(Defs.branch_dir)/\#(Defs.branch_go)

		package \#(Defs.branch)

		const Message = "\#(Defs.branch) v1"

		"""#
}

Steps: branch_initial_commit: preguide.#Command & {
	Source: """
		\(Defs.git.add) \(Defs.branch_go) go.mod
		\(Defs.git.commit) -m 'Initial commit of \(Defs.branch) module'
		\(Defs.git.tag) v1.0.0
		\(Defs.git.push) origin main v1.0.0
		"""
}

Steps: branch_check_initial_porcelain: preguide.#Command & {
	InformationOnly: true
	Source: """
		[ "$(git status --porcelain)" == "" ] || (git status && false)
		"""
}

Steps: branch_create_v1_branch: preguide.#Command & {
	Source: """
		\(Defs.git.branch) main.v1
		\(Defs.git.push) origin main.v1
		"""
}

Steps: branch_go_mod_v2: preguide.#Upload & {
	Target:   "\(Defs.branch_dir)/go.mod"
	Language: "go.mod"
	Source:   #"""
		// \#(Defs.branch_dir)/go.mod

		module \#(Defs.branch_mod)/v2

		go 1.15

		"""#
}

Steps: branch_go_v2: preguide.#Upload & {
	Target: "\(Defs.branch_dir)/\(Defs.branch_go)"
	Source: #"""
		// \#(Defs.branch_dir)/\#(Defs.branch_go)

		package \#(Defs.branch)

		const Message = "\#(Defs.branch) v2"

		"""#
}

Steps: branch_v2_commit: preguide.#Command & {
	Source: """
		\(Defs.git.add) \(Defs.branch_go) go.mod
		\(Defs.git.commit) -m 'v2 commit of \(Defs.branch) module'
		\(Defs.git.tag) v2.0.0
		\(Defs.git.push) origin main v2.0.0
		"""
}

Steps: branch_check_v2_porcelain: preguide.#Command & {
	InformationOnly: true
	Source: """
		[ "$(git status --porcelain)" == "" ] || (git status && false)
		"""
}

Steps: subdir_init: preguide.#Command & {
	Source: """
		mkdir \(Defs.subdir_dir)
		cd \(Defs.subdir_dir)
		\(Defs.cmdgo.modinit) \(Defs.subdir_mod)
		\(Defs.git.init)
		\(Defs.git.remote) add origin \(Defs.subdir_vcs)
		"""
}

Steps: subdir_go_initial: preguide.#Upload & {
	Target: "\(Defs.subdir_dir)/\(Defs.subdir_go)"
	Source: #"""
		// \#(Defs.subdir_dir)/\#(Defs.subdir_go)

		package \#(Defs.subdir)

		const Message = "\#(Defs.subdir) v1"

		"""#
}

Steps: subdir_initial_commit: preguide.#Command & {
	Source: """
		\(Defs.git.add) \(Defs.subdir_go) go.mod
		\(Defs.git.commit) -m 'Initial commit of \(Defs.subdir) module'
		\(Defs.git.tag) v1.0.0
		\(Defs.git.push) origin main v1.0.0
		"""
}

Steps: subdir_check_initial_porcelain: preguide.#Command & {
	InformationOnly: true
	Source: """
		[ "$(git status --porcelain)" == "" ] || (git status && false)
		"""
}

Steps: subdir_create_v2_subdir: preguide.#Command & {
	Source: """
		mkdir v2
		cp go.mod \(Defs.subdir_go) v2
		"""
}

Steps: subdir_go_mod_v2: preguide.#Upload & {
	Target:   "\(Defs.subdir_dir)/v2/go.mod"
	Language: "go.mod"
	Source:   #"""
		// \#(Defs.subdir_dir)/v2/go.mod

		module \#(Defs.subdir_mod)/v2

		go 1.15

		"""#
}

Steps: subdir_go_v2: preguide.#Upload & {
	Target: "\(Defs.subdir_dir)/v2/\(Defs.subdir_go)"
	Source: #"""
		// \#(Defs.subdir_dir)/v2/\#(Defs.subdir_go)

		package \#(Defs.subdir)

		const Message = "\#(Defs.subdir) v2"

		"""#
}

Steps: subdir_v2_commit: preguide.#Command & {
	Source: """
		\(Defs.git.add) v2
		\(Defs.git.commit) -m 'v2 commit of \(Defs.subdir) module'
		\(Defs.git.tag) v2.0.0
		\(Defs.git.push) origin main v2.0.0
		"""
}

Steps: subdir_check_v2_porcelain: preguide.#Command & {
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
		// \#(Defs.gopher_dir)/\#(Defs.gopher_go)

		package main

		import (
			"fmt"

			\#(Defs.branch) "\#(Defs.branch_mod)"
			\#(Defs.branch)_v2 "\#(Defs.branch_mod)/v2"
			\#(Defs.subdir) "\#(Defs.subdir_mod)"
			\#(Defs.subdir)_v2 "\#(Defs.subdir_mod)/v2"
		)

		func main() {
			fmt.Printf("\#(Defs.branch).Message: %v\n", \#(Defs.branch).Message)
			fmt.Printf("\#(Defs.branch)/v2.Message: %v\n", \#(Defs.branch)_v2.Message)
			fmt.Printf("\#(Defs.subdir).Message: %v\n", \#(Defs.subdir).Message)
			fmt.Printf("\#(Defs.subdir)/v2.Message: %v\n", \#(Defs.subdir)_v2.Message)
		}

		"""#
}

Steps: gopher_get_deps: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.get) \(Defs.branch_mod)@v1.0.0
		\(Defs.cmdgo.get) \(Defs.branch_mod)/v2@v2.0.0
		\(Defs.cmdgo.get) \(Defs.subdir_mod)@v1.0.0
		\(Defs.cmdgo.get) \(Defs.subdir_mod)/v2@v2.0.0
		"""
}

Steps: gopher_run: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.run) .
		"""
}
