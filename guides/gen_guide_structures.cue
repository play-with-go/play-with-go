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
				Image: "playwithgo/go1.15.1@sha256:ce6cfb9fbc282b872db4b24fea0b24277e6751b67013ce26b77bc8a776296831"
			}
		}
	}]
}

