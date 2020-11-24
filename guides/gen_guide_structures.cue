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
				Image: "playwithgo/go1.15.5@sha256:1c332c6b4e73dee8075badc66fe23c7fe51c44ddd2becb6cffc2db81bdaa0b06"
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
				Image: "playwithgo/go1.15.5@sha256:1c332c6b4e73dee8075badc66fe23c7fe51c44ddd2becb6cffc2db81bdaa0b06"
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
"2020-08-13-installing-go": {
	Delims: ["{{{", "}}}"]
	Terminals: [{
		Name:        "term1"
		Description: "The main terminal"
		Scenarios: {
			go115: {
				Image: "playwithgo/installgo1.15.5@sha256:549ca296f74aab093428a0a8b283f9d7d6c0a8390af7fd33129bbdb983c461ba"
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
				Image: "playwithgo/go1.15.5@sha256:1c332c6b4e73dee8075badc66fe23c7fe51c44ddd2becb6cffc2db81bdaa0b06"
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
				Image: "playwithgo/go1.15.5@sha256:1c332c6b4e73dee8075badc66fe23c7fe51c44ddd2becb6cffc2db81bdaa0b06"
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
				Image: "playwithgo/go1.15.5@sha256:1c332c6b4e73dee8075badc66fe23c7fe51c44ddd2becb6cffc2db81bdaa0b06"
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
				Image: "playwithgo/go1.16-tip@sha256:af9da82837751157485d9c2008b4ad950037502d9d18715cb1e617f4b2d6f169"
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
				Image: "playwithgo/go1.16-tip@sha256:af9da82837751157485d9c2008b4ad950037502d9d18715cb1e617f4b2d6f169"
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
				Image: "playwithgo/go1.15.5@sha256:1c332c6b4e73dee8075badc66fe23c7fe51c44ddd2becb6cffc2db81bdaa0b06"
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
				Image: "playwithgo/go1.15.5@sha256:1c332c6b4e73dee8075badc66fe23c7fe51c44ddd2becb6cffc2db81bdaa0b06"
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
"2020-11-19-major-version-repository-structure": {
	Delims: ["{{{", "}}}"]
	Presteps: [{
		Package: "github.com/play-with-go/gitea"
		Path:    "/newuser"
		Args: {
			Repos: [{
				Pattern: "branch"
				Private: false
				Var:     "BRANCH"
			}, {
				Pattern: "subdir"
				Private: false
				Var:     "SUBDIR"
			}]
		}
	}]
	Terminals: [{
		Name:        "term1"
		Description: "The main terminal"
		Scenarios: {
			go115: {
				Image: "playwithgo/go1.15.5@sha256:1c332c6b4e73dee8075badc66fe23c7fe51c44ddd2becb6cffc2db81bdaa0b06"
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

