package conf

import "github.com/play-with-go/preguide"

preguide.#PrestepServiceConfig

"github.com/play-with-go/gitea": preguide.#PrestepConfig & {
	Endpoint: "http://gitea_prestep:8080"
	Env: ["PLAYWITHGO_ROOTCA"]
	Networks: ["playwithgo_gitea"]
}
