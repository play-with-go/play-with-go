package guides

"2018-10-19-go-fundamentals": {
	Delims: ["{{{", "}}}"]
	Presteps: [{
		Package: "github.com/play-with-go/gitea"
		Path:    "/newuser"
		Args: {
			Repos: [{
				Pattern: "greetings"
				Private: false
				Var:     "GREETINGS"
			}, {
				Pattern: "hello"
				Private: false
				Var:     "HELLO"
			}]
		}
	}]
	Terminals: [{
		Name:        "term1"
		Description: "The main terminal"
		Scenarios: {
			go115: {
				Image: "playwithgo/go1.15.5@sha256:8d50772f8623566fa9cfa98d2a975d49cc44824c6f202ee65ab1cadf915a4445"
			}
		}
	}]
	Scenarios: [{
		Name:        "go115"
		Description: "Go 1.15"
	}]
	Networks: ["playwithgo_pwg"]
	Env: []
}
"2019-10-15-get-started-with-go": {
	Delims: ["{{{", "}}}"]
	Terminals: [{
		Name:        "term1"
		Description: "The main terminal"
		Scenarios: {
			go115: {
				Image: "playwithgo/go1.15.5@sha256:8d50772f8623566fa9cfa98d2a975d49cc44824c6f202ee65ab1cadf915a4445"
			}
		}
	}]
	Scenarios: [{
		Name:        "go115"
		Description: "Go 1.15"
	}]
	Networks: ["playwithgo_pwg"]
	Env: []
}
"2020-09-01-basic-go-modules-example": {
	Delims: ["{{{", "}}}"]
	Presteps: [{
		Package: "github.com/play-with-go/gitea"
		Path:    "/newuser"
		Args: {
			Repos: [{
				Pattern: "mod1"
				Private: false
				Var:     "REPO1"
			}]
		}
	}]
	Terminals: [{
		Name:        "term1"
		Description: "The main terminal"
		Scenarios: {
			go115: {
				Image: "playwithgo/go1.15.5@sha256:8d50772f8623566fa9cfa98d2a975d49cc44824c6f202ee65ab1cadf915a4445"
			}
		}
	}]
	Scenarios: [{
		Name:        "go115"
		Description: "Go 1.15"
	}]
	Networks: ["playwithgo_pwg"]
	Env: []
}
"2020-10-07-intro-to-play-with-go-dev": {
	Delims: ["{{{", "}}}"]
	Presteps: [{
		Package: "github.com/play-with-go/gitea"
		Path:    "/newuser"
		Args: {
			Repos: [{
				Pattern: "hello"
				Private: false
				Var:     "REPO1"
			}]
		}
	}]
	Terminals: [{
		Name:        "term1"
		Description: "The main terminal"
		Scenarios: {
			go115: {
				Image: "playwithgo/go1.15.5@sha256:8d50772f8623566fa9cfa98d2a975d49cc44824c6f202ee65ab1cadf915a4445"
			}
		}
	}]
	Scenarios: [{
		Name:        "go115"
		Description: "Go 1.15"
	}]
	Networks: ["playwithgo_pwg"]
	Env: []
}
"2020-11-05-tools-as-dependencies": {
	Delims: ["{{{", "}}}"]
	Presteps: [{
		Package: "github.com/play-with-go/gitea"
		Path:    "/newuser"
		Args: {
			Repos: [{
				Pattern: "painkiller"
				Private: false
				Var:     "PAINKILLER"
			}]
		}
	}]
	Terminals: [{
		Name:        "term1"
		Description: "The main terminal"
		Scenarios: {
			go115: {
				Image: "playwithgo/go1.15.5@sha256:8d50772f8623566fa9cfa98d2a975d49cc44824c6f202ee65ab1cadf915a4445"
			}
		}
	}]
	Scenarios: [{
		Name:        "go115"
		Description: "Go 1.15"
	}]
	Networks: ["playwithgo_pwg"]
	Env: []
}
"2020-11-08-retract-module-versions": {
	Delims: ["{{{", "}}}"]
	Presteps: [{
		Package: "github.com/play-with-go/gitea"
		Path:    "/newuser"
		Args: {
			Repos: [{
				Pattern: "proverb"
				Private: false
				Var:     "PROVERB"
			}]
		}
	}]
	Terminals: [{
		Name:        "term1"
		Description: "The main terminal"
		Scenarios: {
			go116: {
				Image: "playwithgo/go1.16-tip@sha256:1aecbb5f223c9140b4168003b67b3075703381b27362325c6b78e8db6eacbd24"
			}
		}
	}]
	Scenarios: [{
		Name:        "go116"
		Description: "Go 1.16"
	}]
	Networks: ["playwithgo_pwg"]
	Env: []
}
"2020-11-09-installing-go-programs-directly": {
	Delims: ["{{{", "}}}"]
	Terminals: [{
		Name:        "term1"
		Description: "The main terminal"
		Scenarios: {
			go116: {
				Image: "playwithgo/go1.16-tip@sha256:1aecbb5f223c9140b4168003b67b3075703381b27362325c6b78e8db6eacbd24"
			}
		}
	}]
	Scenarios: [{
		Name:        "go116"
		Description: "Go 1.16"
	}]
	Networks: ["playwithgo_pwg"]
	Env: []
}
"2020-11-09-using-staticcheck": {
	Delims: ["{{{", "}}}"]
	Terminals: [{
		Name:        "term1"
		Description: "The main terminal"
		Scenarios: {
			go115: {
				Image: "playwithgo/go1.15.5@sha256:8d50772f8623566fa9cfa98d2a975d49cc44824c6f202ee65ab1cadf915a4445"
			}
		}
	}]
	Scenarios: [{
		Name:        "go115"
		Description: "Go 1.15"
	}]
	Networks: ["playwithgo_pwg"]
	Env: []
}
"2020-11-12-working-with-private-modules": {
	Delims: ["{{{", "}}}"]
	Presteps: [{
		Package: "github.com/play-with-go/gitea"
		Path:    "/newuser"
		Args: {
			Repos: [{
				Pattern: "public"
				Private: false
				Var:     "PUBLIC"
			}, {
				Pattern: "private"
				Private: true
				Var:     "PRIVATE"
			}]
		}
	}]
	Terminals: [{
		Name:        "term1"
		Description: "The main terminal"
		Scenarios: {
			go115: {
				Image: "playwithgo/go1.15.5@sha256:8d50772f8623566fa9cfa98d2a975d49cc44824c6f202ee65ab1cadf915a4445"
			}
		}
	}]
	Scenarios: [{
		Name:        "go115"
		Description: "Go 1.15"
	}]
	Networks: ["playwithgo_pwg"]
	Env: []
}

