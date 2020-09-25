package guides

"2020-09-01-basic-go-modules-example": {
	Delims: ["{{{", "}}}"]
	Presteps: [{
		Package: "github.com/play-with-go/gitea"
		Path:    "/newuser"
		Args: {
			Repos: [{
				Pattern: "mod1*"
				Var:     "REPO1"
			}]
		}
	}]
	Terminals: [{
		Name:        "term1"
		Description: "The main terminal"
		Scenarios: {
			go115: {
				Image: "playwithgo/go1.15.1@sha256:af32904111a7ae381d6821f4ab217b2bce58996267e22f2cf1cd27a16199c128"
			}
		}
	}]
	Scenarios: [{
		Name:        "go115"
		Description: "Go 1.15"
	}]
	Networks: ["playwithgo_gitea"]
	Env: ["PLAYWITHGO_ROOTCA"]
}

