package guide

import (

	"github.com/play-with-go/preguide"
)

Defs: {
	_#commonDefs
	go_help_env: "\(_#commonDefs.cmdgo.help) env"
}

Scenarios: go119: preguide.#Scenario & {
	Description: "Go 1.15"
}

Terminals: term1: preguide.#Terminal & {
	Description: "The main terminal"
	Scenarios: go119: Image: _#installGo
}

Steps: start_dir: preguide.#Command & {
	Stmts: """
		pwd
		"""
}

Steps: download_go: preguide.#Command & {
	Stmts: """
		wget -q https://golang.org/dl/\(_#go119LatestVersion).linux-$GOARCH.tar.gz
		"""
}

Steps: install_go: preguide.#Command & {
	Stmts: """
		sudo tar -C /usr/local -xzf \(_#go119LatestVersion).linux-$GOARCH.tar.gz
		"""
}

Steps: add_install_to_path: preguide.#Command & {
	Stmts: """
		echo export PATH="/usr/local/go/bin:$PATH" >> $HOME/.profile
		"""
}

Steps: source_profile: preguide.#Command & {
	Stmts: """
		source $HOME/.profile
		"""
}

Steps: go_version: preguide.#Command & {
	Stmts: [{
		Cmd: Defs.cmdgo.version
	}]
}

Steps: go_env: preguide.#Command & {
	Stmts: [{
		Cmd: Defs.cmdgo.env
	}]
}

Steps: go_env_gobin: preguide.#Command & {
	Stmts: """
		\(Defs.cmdgo.env) GOBIN
		"""
}

Steps: go_env_set_gobin: preguide.#Command & {
	Stmts: """
		\(Defs.cmdgo.env) -w GOBIN=/path/to/my/gobin
		"""
}

Steps: go_env_check_gobin: preguide.#Command & {
	Stmts: """
		\(Defs.cmdgo.env) GOBIN
		"""
}

Steps: go_env_env: preguide.#Command & {
	Stmts: """
		\(Defs.cmdgo.env) GOENV
		"""
}

Steps: go_env_unset_gobin: preguide.#Command & {
	Stmts: """
		\(Defs.cmdgo.env) -w GOBIN=
		"""
}

Steps: go_env_check_gobin_again: preguide.#Command & {
	Stmts: """
		\(Defs.cmdgo.env) GOBIN
		"""
}

Steps: go_help_env: preguide.#Command & {
	InformationOnly: true
	Stmts:           """
		\(Defs.go_help_env)
		"""
}

Steps: gobin_not_set: preguide.#Command & {
	Stmts: """
		\(Defs.cmdgo.env) GOBIN
		"""
}

Steps: add_gobin_bin_to_path: preguide.#Command & {
	Stmts: """
		echo export PATH="$(go env GOPATH)/bin:$PATH" >> $HOME/.profile
		"""
}

Steps: source_profile_again: preguide.#Command & {
	Stmts: """
		source $HOME/.profile
		"""
}

Steps: echo_path: preguide.#Command & {
	Stmts: """
		echo $PATH
		"""
}
