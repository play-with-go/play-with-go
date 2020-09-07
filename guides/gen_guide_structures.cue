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
				Image: "playwithgo/go1.15.1@sha256:009b09b0b12874cb1dd362bc2471e39d430f6c2c7cac47dc9db2ab7a4290e59b"
			}
		}
	}]
}

