package guides

"2020-09-01-basic-go-modules-example": {
	Scenarios: [{
		Name:        "go115"
		Description: "Go 1.15"
	}]
	Networks: ["playwithgo_gitea"]
	Env: ["PLAYWITHGO_ROOTCA"]
	Presteps: [{
		Path:    "/newuser"
		Package: "github.com/play-with-go/gitea"
		Args: {
			Repos: [{
				Pattern: "mod1*"
				Var:     "REPO1"
			}]
		}
	}]
	Delims: ["{{", "}}"]
	Terminals: [{
		Name:        "term1"
		Description: "The main terminal"
		Scenarios: {
			go115: {
				Image: "playwithgo/go1.15@sha256:ec830fd226bdf40efd20d6d12a100f3176bc3d86b7e01c8772a7b7434306ffd4"
			}
		}
	}]
}

