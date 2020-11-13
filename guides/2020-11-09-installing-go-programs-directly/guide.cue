package guide

import (
	"github.com/play-with-go/preguide"
)

Defs: {
	_#commonDefs
	mkcert:         "mkcert"
	mkcert_pkg:     "filippo.io/mkcert"
	mkcert_version: "v1.4.2"
	mktemp:         "mktemp -d"
}

Scenarios: go116: preguide.#Scenario & {
	Description: "Go 1.16"
}

Terminals: term1: preguide.#Terminal & {
	Description: "The main terminal"
	Scenarios: go116: Image: _#go116LatestImage
}

Steps: goversion: preguide.#Command & {
	Source: """
		go version
		"""
}

Steps: go115_mkcert_get: preguide.#Command & {
	Source: """
		go get \(Defs.mkcert_pkg)
		"""
}

Steps: go115_mkcert_modules_get: preguide.#Command & {
	Source: """
		(cd $(\(Defs.mktemp)); GO111MODULE=on go get \(Defs.mkcert_pkg)@\(Defs.mkcert_version))
		"""
}

Steps: go116_mkcert_install: preguide.#Command & {
	Source: """
		go install \(Defs.mkcert_pkg)@\(Defs.mkcert_version)
		"""
}

Steps: which_mkcert: preguide.#Command & {
	Source: """
		which \(Defs.mkcert)
		"""
}

Steps: run_mkcert: preguide.#Command & {
	Source: """
		\(Defs.mkcert) -version
		"""
}

Steps: goversion_mkcert: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.version) -m $(which \(Defs.mkcert))
		"""
}
