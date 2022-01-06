package guide

import (

	"github.com/play-with-go/preguide"
)

Defs: {
	_#commonDefs
	go_help_env: "\(_#commonDefs.cmdgo.help) env"
}

Scenarios: go115: preguide.#Scenario & {
	Description: "Go 1.15"
}

Terminals: term1: preguide.#Terminal & {
	Description: "The main terminal"
	Scenarios: go115: Image: _#installGo
}

Steps: start_dir: preguide.#Command & {
	Source: """
		pwd
		"""
}

Steps: download_go: preguide.#Command & {
	Source: """
		wget -q https://golang.org/dl/\(_#go115LatestVersion).linux-$GOARCH.tar.gz
		"""
}

Steps: install_go: preguide.#Command & {
	Source: """
		sudo tar -C /usr/local -xzf \(_#go115LatestVersion).linux-$GOARCH.tar.gz
		"""
}

Steps: add_install_to_path: preguide.#Command & {
	Source: """
		echo export PATH="/usr/local/go/bin:$PATH" >> $HOME/.profile
		"""
}

Steps: source_profile: preguide.#Command & {
	Source: """
		source $HOME/.profile
		"""
}

Steps: go_version: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.version)
		"""
}

Steps: go_env: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.env)
		"""
}

Steps: go_env_gobin: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.env) GOBIN
		"""
}

Steps: go_env_set_gobin: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.env) -w GOBIN=/path/to/my/gobin
		"""
}

Steps: go_env_check_gobin: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.env) GOBIN
		"""
}

Steps: go_env_env: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.env) GOENV
		"""
}

Steps: go_env_unset_gobin: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.env) -w GOBIN=
		"""
}

Steps: go_env_check_gobin_again: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.env) GOBIN
		"""
}

Steps: go_help_env: preguide.#Command & {
	InformationOnly: true
	Source:          """
		\(Defs.go_help_env)
		"""
}

Steps: gobin_not_set: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.env) GOBIN
		"""
}

Steps: add_gobin_bin_to_path: preguide.#Command & {
	Source: """
		echo export PATH="$(go env GOPATH)/bin:$PATH" >> $HOME/.profile
		"""
}

Steps: source_profile_again: preguide.#Command & {
	Source: """
		source $HOME/.profile
		"""
}

Steps: echo_path: preguide.#Command & {
	Source: """
		echo $PATH
		"""
}
