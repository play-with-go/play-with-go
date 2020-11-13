package guide

import (
	"github.com/play-with-go/preguide"
)

Defs: {
	_#commonDefs
	staticcheck:         "staticcheck"
	staticcheck_pkg:     "honnef.co/go/tools/cmd/staticcheck"
	staticcheck_version: "v0.0.1-2020.1.6"
	mktemp:              "mktemp -d"
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

Steps: go115_staticcheck_get: preguide.#Command & {
	Source: """
		go get \(Defs.staticcheck_pkg)
		"""
}

Steps: go115_staticcheck_modules_get: preguide.#Command & {
	Source: """
		(cd $(\(Defs.mktemp)); GO111MODULE=on go get \(Defs.staticcheck_pkg)@\(Defs.staticcheck_version))
		"""
}

Steps: go116_staticcheck_install: preguide.#Command & {
	Source: """
		go install \(Defs.staticcheck_pkg)@\(Defs.staticcheck_version)
		"""
}

Steps: which_staticcheck: preguide.#Command & {
	Source: """
		which \(Defs.staticcheck)
		"""
}

Steps: run_staticcheck: preguide.#Command & {
	Source: """
		\(Defs.staticcheck) -version
		"""
}

Steps: goversion_staticcheck: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.version) -m $(which \(Defs.staticcheck))
		"""
}
