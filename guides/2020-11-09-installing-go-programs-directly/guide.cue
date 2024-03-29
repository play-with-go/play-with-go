package guide

import (
	"github.com/play-with-go/preguide"
)

Defs: {
	_#commonDefs
	mkcert:         "mkcert"
	mkcert_pkg:     "filippo.io/mkcert"
	mkcert_version: "v1.4.4"
	mktemp:         "mktemp -d"
}

Scenarios: go119: preguide.#Scenario & {
	Description: "Go 1.16"
}

Terminals: term1: preguide.#Terminal & {
	Description: "The main terminal"
	Scenarios: go119: Image: _#go119LatestImage
}

Steps: goversion: preguide.#Command & {
	Stmts: [{
		Cmd: "go version"
	}]
}

Steps: go119_mkcert_install: preguide.#Command & {
	Stmts: """
		go install \(Defs.mkcert_pkg)@\(Defs.mkcert_version)
		"""
}

Steps: which_mkcert: preguide.#Command & {
	Stmts: """
		which \(Defs.mkcert)
		"""
}

Steps: run_mkcert: preguide.#Command & {
	Stmts: """
		\(Defs.mkcert) -version
		"""
}

Steps: goversion_mkcert: preguide.#Command & {
	Stmts: [{
		Cmd:        "\(Defs.cmdgo.version) -m $(which \(Defs.mkcert))"
		Sanitisers: _#goVersionMSanitisers
	}]
}
