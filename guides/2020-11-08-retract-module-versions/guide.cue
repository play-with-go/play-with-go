package guide

import (
	"github.com/play-with-go/gitea"
	"github.com/play-with-go/preguide"
)

Presteps: [gitea.#PrestepNewUser & {
	Args: {
		Repos: [
			{Var: "PROVERB", Pattern: Defs.proverb},
		]
	}
}]

Defs: {
	_#commonDefs
	proverb:      "proverb"
	proverb_vcs:  "https://\(proverb_mod).git"
	proverb_mod:  "{{{.PROVERB}}}"
	proverb_dir:  "/home/gopher/\(proverb)"
	proverb_go:   "\(proverb).go"
	proverb_v010: "v0.1.0"
	proverb_v020: "v0.2.0"
	proverb_v030: "v0.3.0"
	proverb_v040: "v0.4.0"
	proverb_v100: "v1.0.0"
	proverb_v101: "v1.0.1"
	proverb_v102: "v1.0.2"
	gopher:       "gopher"
	gopher_mod:   gopher
	gopher_dir:   "/home/gopher/\(gopher)"
	gopher_go:    "\(gopher).go"
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

Steps: proverb_create: preguide.#Command & {
	Source: """
		mkdir \(Defs.proverb_dir)
		cd \(Defs.proverb_dir)
		\(Defs.git.init)
		\(Defs.git.remote) add origin \(Defs.proverb_vcs)
		go mod init \(Defs.proverb_mod)
		"""
}

Steps: proverb_go_initial: preguide.#Upload & {
	Target: "\(Defs.proverb_dir)/\(Defs.proverb_go)"
	Source: """
		package proverb

		// Go returns a Go proverb
		func Go() string {
			return "Don't communicate by sharing memory, share memory by communicating."
		}

		"""
}

Steps: proverb_initial_commit: preguide.#Command & {
	Source: """
		\(Defs.git.add) -A
		\(Defs.git.commit) -m "Initial commit"
		\(Defs.git.push) origin main
		"""
}

Steps: proverb_check_initial_porcelain: preguide.#Command & {
	InformationOnly: true
	Source: """
		[ "$(git status --porcelain)" == "" ] || (git status && false)
		"""
}

Steps: proverb_tag_v010: preguide.#Command & {
	Source: """
		\(Defs.git.tag) \(Defs.proverb_v010)
		\(Defs.git.push) origin \(Defs.proverb_v010)
		"""
}

Steps: gopher_create: preguide.#Command & {
	Source: """
		mkdir \(Defs.gopher_dir)
		cd \(Defs.gopher_dir)
		go mod init \(Defs.gopher_mod)
		"""
}

Steps: gopher_go_initial: preguide.#Upload & {
	Target: "\(Defs.gopher_dir)/\(Defs.gopher_go)"
	Source: """
		package main

		import (
			"fmt"

			"\(Defs.proverb_mod)"
		)

		func main() {
			fmt.Println(proverb.Go())
		}

		"""
}

Steps: gopher_add_dep_proverb_v010: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.get) \(Defs.proverb_mod)@\(Defs.proverb_v010)
		"""
}

Steps: gopher_run_initial: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.run) .
		"""
}

Steps: proverb_cd_concurrency_change: preguide.#Command & {
	Source: """
		cd \(Defs.proverb_dir)
		"""
}

Steps: proverb_go_concurrency: preguide.#Upload & {
	Target:   "\(Defs.proverb_dir)/\(Defs.proverb_go)"
	Renderer: preguide.#RenderDiff & {Pre: Steps.proverb_go_initial.Source}
	Source: """
		package proverb

		// Go returns a Go proverb
		func Go() string {
			return "Concurrency is parallelism."
		}

		"""
}

Steps: proverb_concurrency_commit: preguide.#Command & {
	Source: """
		\(Defs.git.add) -A
		\(Defs.git.commit) -m "Switch Go proverb to something more famous"
		\(Defs.git.push) origin main
		"""
}

Steps: proverb_check_concurrency_porcelain: preguide.#Command & {
	InformationOnly: true
	Source: """
		[ "$(git status --porcelain)" == "" ] || (git status && false)
		"""
}

Steps: proverb_tag_v020: preguide.#Command & {
	Source: """
		\(Defs.git.tag) \(Defs.proverb_v020)
		\(Defs.git.push) origin \(Defs.proverb_v020)
		"""
}

Steps: gopher_use_v020: preguide.#Command & {
	Source: """
		cd \(Defs.gopher_dir)
		\(Defs.cmdgo.get) \(Defs.proverb_mod)@\(Defs.proverb_v020)
		\(Defs.cmdgo.run) .
		"""
}

Steps: proverb_return_to_retract_v020: preguide.#Command & {
	Source: """
		cd \(Defs.proverb_dir)
		"""
}

Steps: proverb_retract_v020: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.modedit) -retract=\(Defs.proverb_v020)
		"""
}

Steps: proverb_cat_v020_retract: preguide.#Command & {
	Source: """
		cat go.mod
		"""
}

Steps: proverb_comment_retraction: preguide.#Upload & {
	Target: "\(Defs.proverb_dir)/go.mod"
	Source: """
		module \(Defs.proverb_mod)

		go 1.16

		// Go proverb was totally wrong
		retract \(Defs.proverb_v020)

		"""
}

Steps: proverb_go_fix_concurrency_bug: preguide.#Upload & {
	Target:   "\(Defs.proverb_dir)/\(Defs.proverb_go)"
	Renderer: preguide.#RenderDiff & {Pre: Steps.proverb_go_concurrency.Source}
	Source: """
		package proverb

		// Go returns a Go proverb
		func Go() string {
			return "Concurrency is not parallelism."
		}

		"""
}

Steps: proverb_tag_v030: preguide.#Command & {
	Source: """
		\(Defs.git.add) -A
		\(Defs.git.commit) -m "Fix severe error in Go proverb"
		\(Defs.git.push) origin main
		\(Defs.git.tag) \(Defs.proverb_v030)
		\(Defs.git.push) origin \(Defs.proverb_v030)
		"""
}

Steps: proverb_check_v030_porcelain: preguide.#Command & {
	InformationOnly: true
	Source: """
		[ "$(git status --porcelain)" == "" ] || (git status && false)
		"""
}

Steps: gopher_use_v030: preguide.#Command & {
	Source: """
		cd \(Defs.gopher_dir)
		\(Defs.cmdgo.get) \(Defs.proverb_mod)@\(Defs.proverb_v030)
		"""
}

Steps: gopher_run_v030: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.run) .
		"""
}

Steps: gopher_sleep_on_proxy: preguide.#Command & {
	Source: """
		sleep \(Defs.proxygolangorg.waitforcache)
		"""
}

Steps: gopher_list_proverb: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.list) -m -versions \(Defs.proverb_mod)
		"""
}

Steps: gopher_list_proverb_retracted: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.list) -m -versions -retracted \(Defs.proverb_mod)
		"""
}

Steps: gopher_use_retracted_v020: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.get) \(Defs.proverb_mod)@\(Defs.proverb_v020)
		"""
}

Steps: gopher_run_retracted_v020: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.run) .
		"""
}

Steps: gopher_list_versions: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.list) -m -u all
		"""
}

Steps: gopher_use_latest_unretracted: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.get) \(Defs.proverb_mod)@\(Defs.cmdgo.vlatest)
		"""
}

Steps: proverb_return_life: preguide.#Command & {
	Source: """
		cd \(Defs.proverb_dir)
		"""
}

Steps: proverb_go_life_advice: preguide.#Upload & {
	Target:   "\(Defs.proverb_dir)/\(Defs.proverb_go)"
	Renderer: preguide.#RenderDiff & {Pre: Steps.proverb_go_fix_concurrency_bug.Source}
	Source: """
		package proverb

		// Go returns a Go proverb
		func Go() string {
			return "Concurrency is not parallelism."
		}

		// Life returns a proverb useful for day-to-day living
		func Life() string {
			return "A bird in the hand is worth two in the bush."
		}

		"""
}

Steps: proverb_life_commit: preguide.#Command & {
	Source: """
		\(Defs.git.add) -A
		\(Defs.git.commit) -m "Add Life() proverb"
		\(Defs.git.push) origin main
		"""
}

Steps: proverb_check_v100_porcelain: preguide.#Command & {
	InformationOnly: true
	Source: """
		[ "$(git status --porcelain)" == "" ] || (git status && false)
		"""
}

Steps: proverb_tag_v100: preguide.#Command & {
	Source: """
		\(Defs.git.tag) \(Defs.proverb_v100)
		\(Defs.git.push) origin \(Defs.proverb_v100)
		"""
}

Steps: proverb_tag_v040: preguide.#Command & {
	Source: """
		\(Defs.git.tag) \(Defs.proverb_v040)
		\(Defs.git.push) origin \(Defs.proverb_v040)
		"""
}

Steps: proverb_retract_v100: preguide.#Upload & {
	Target:   "\(Defs.proverb_dir)/go.mod"
	Renderer: preguide.#RenderDiff & {Pre: Steps.proverb_comment_retraction.Source}
	Source:   """
		module \(Defs.proverb_mod)

		go 1.16

		retract (
			// Go proverb was totally wrong
			\(Defs.proverb_v020)

			// Published v1 too early
			[\(Defs.proverb_v100), \(Defs.proverb_v101)]
		)

		"""
}

Steps: proverb_tag_v101: preguide.#Command & {
	Source: """
		\(Defs.git.add) -A
		\(Defs.git.commit) -m "Retract [\(Defs.proverb_v100), \(Defs.proverb_v101)]"
		\(Defs.git.push) origin main
		\(Defs.git.tag) \(Defs.proverb_v101)
		\(Defs.git.push) origin \(Defs.proverb_v101)
		"""
}

Steps: proverb_check_v101_porcelain: preguide.#Command & {
	InformationOnly: true
	Source: """
		[ "$(git status --porcelain)" == "" ] || (git status && false)
		"""
}

Steps: gopher_cd_use_v100: preguide.#Command & {
	Source: """
		cd \(Defs.gopher_dir)
		"""
}

Steps: temp_get_v101: preguide.#Command & {
	InformationOnly: true
	Source:          """
		(
			cd $(mktemp -d)
			export GOPATH=$(mktemp -d)
			\(Defs.cmdgo.modinit) mod.com
			\(Defs.cmdgo.get) -x \(Defs.proverb_mod)@\(Defs.proverb_v040)
			\(Defs.cmdgo.get) -x \(Defs.proverb_mod)@\(Defs.proverb_v100)
			\(Defs.cmdgo.get) -x \(Defs.proverb_mod)@\(Defs.proverb_v101)
			sleep \(Defs.proxygolangorg.waitforcache)
		) > /dev/null 2>&1
		"""
}

Steps: gopher_use_v101: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.get) \(Defs.proverb_mod)@\(Defs.proverb_v100)
		\(Defs.cmdgo.get) \(Defs.proverb_mod)@\(Defs.proverb_v101)
		\(Defs.cmdgo.get) \(Defs.proverb_mod)@\(Defs.proverb_v040)
		"""
}

Steps: gopher_sleep_on_proxy_again: preguide.#Command & {
	Source: """
		sleep \(Defs.proxygolangorg.waitforcache)
		"""
}

Steps: gopher_list_proverb_v101_retracted: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.list) -m -versions -retracted \(Defs.proverb_mod)
		"""
}

Steps: gopher_list_proverb_v101_nonretracted: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.list) -m -versions \(Defs.proverb_mod)
		"""
}

Steps: gopher_go_update_life_proverb: preguide.#Upload & {
	Target:   "\(Defs.gopher_dir)/\(Defs.gopher_go)"
	Renderer: preguide.#RenderDiff & {Pre: Steps.gopher_go_initial.Source}
	Source:   #"""
		package main

		import (
			"fmt"

			"\#(Defs.proverb_mod)"
		)

		func main() {
			fmt.Printf("Go proverb: %v\n", proverb.Go())
			fmt.Printf("Life advice: %v\n", proverb.Life())
		}

		"""#
}

Steps: gopher_run_life_proverb: preguide.#Command & {
	Source: """
		\(Defs.cmdgo.run) .
		"""
}
