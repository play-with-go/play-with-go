package conf

import "github.com/play-with-go/preguide"

preguide.#PrestepServiceConfig

"github.com/play-with-go/gitea": preguide.#PrestepConfig & {
	Endpoint: "http://cmd_gitea:8080"
	Env: ["GOPHERLIVE_ROOTCA"]
	Networks: ["playwithgo_pwg"]
}
