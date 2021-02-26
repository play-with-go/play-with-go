@if(controller)

package conf

import "github.com/play-with-go/preguide"

preguide.#PrestepServiceConfig

"github.com/play-with-go/gitea": preguide.#PrestepConfig & {
	Endpoint: "http://cmd_gitea:8080"
	Networks: ["playwithgo_pwg"]
}
