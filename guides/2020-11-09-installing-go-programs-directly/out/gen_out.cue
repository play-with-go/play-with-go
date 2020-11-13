package out

Terminals: [{
	Description: "The main terminal"
	Scenarios: {
		go116: {
			Image: "playwithgo/go1.16-tip@sha256:16217b6c274599d12d201fab7bf41f151bf0793875b804406946c62150ad3707"
		}
	}
	Name: "term1"
}]
Scenarios: [{
	Description: "Go 1.16"
	Name:        "go116"
}]
Networks: ["playwithgo_pwg"]
Env: []
Steps: {
	goversion_staticcheck: {
		Stmts: [{
			ComparisonOutput: """
				/home/gopher/go/bin/staticcheck: devel +7307e86afd Sun Nov 8 12:19:55 2020 +0000
				\tpath\thonnef.co/go/tools/cmd/staticcheck
				\tmod\thonnef.co/go/tools\tv0.0.1-2020.1.6\th1:W18jzjh8mfPez+AwGLxmOImucz/IFjpNlrKVnaj2YVc=
				\tdep\tgithub.com/BurntSushi/toml\tv0.3.1\th1:WXkYYl6Yr3qBf1K79EBnL4mak0OimBfB0XUf9Vl28OQ=
				\tdep\tgolang.org/x/tools\tv0.0.0-20200410194907-79a7a3126eef\th1:RHORRhs540cYZYrzgU2CPUyykkwZM78hGdzocOo9P8A=
				\tdep\tgolang.org/x/xerrors\tv0.0.0-20191204190536-9bdfabe68543\th1:E7g+9GITq07hpfrRu66IVDexMakfv52eLZ2CXBWiKr4=

				"""
			Output: """
				/home/gopher/go/bin/staticcheck: devel +7307e86afd Sun Nov 8 12:19:55 2020 +0000
				\tpath\thonnef.co/go/tools/cmd/staticcheck
				\tmod\thonnef.co/go/tools\tv0.0.1-2020.1.6\th1:W18jzjh8mfPez+AwGLxmOImucz/IFjpNlrKVnaj2YVc=
				\tdep\tgithub.com/BurntSushi/toml\tv0.3.1\th1:WXkYYl6Yr3qBf1K79EBnL4mak0OimBfB0XUf9Vl28OQ=
				\tdep\tgolang.org/x/tools\tv0.0.0-20200410194907-79a7a3126eef\th1:RHORRhs540cYZYrzgU2CPUyykkwZM78hGdzocOo9P8A=
				\tdep\tgolang.org/x/xerrors\tv0.0.0-20191204190536-9bdfabe68543\th1:E7g+9GITq07hpfrRu66IVDexMakfv52eLZ2CXBWiKr4=

				"""
			ExitCode: 0
			CmdStr:   "go version -m $(which staticcheck)"
			Negated:  false
		}]
		Order:           6
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "goversion_staticcheck"
	}
	run_staticcheck: {
		Stmts: [{
			ComparisonOutput: """
				staticcheck 2020.1.6

				"""
			Output: """
				staticcheck 2020.1.6

				"""
			ExitCode: 0
			CmdStr:   "staticcheck -version"
			Negated:  false
		}]
		Order:           5
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "run_staticcheck"
	}
	which_staticcheck: {
		Stmts: [{
			ComparisonOutput: """
				/home/gopher/go/bin/staticcheck

				"""
			Output: """
				/home/gopher/go/bin/staticcheck

				"""
			ExitCode: 0
			CmdStr:   "which staticcheck"
			Negated:  false
		}]
		Order:           4
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "which_staticcheck"
	}
	go116_staticcheck_install: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "go install honnef.co/go/tools/cmd/staticcheck@v0.0.1-2020.1.6"
			Negated:          false
		}]
		Order:           3
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "go116_staticcheck_install"
	}
	go115_staticcheck_modules_get: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "(cd $(mktemp -d); GO111MODULE=on go get honnef.co/go/tools/cmd/staticcheck@v0.0.1-2020.1.6)"
			Negated:          false
		}]
		Order:           2
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "go115_staticcheck_modules_get"
	}
	go115_staticcheck_get: {
		Stmts: [{
			ComparisonOutput: """

				go: downloading github.com/BurntSushi/toml v0.3.1
				go: downloading golang.org/x/tools v0.0.0-20200410194907-79a7a3126eef
				go: downloading golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543
				go: downloading honnef.co/go/tools v0.0.1-2020.1.6
				"""
			Output: """
				go: downloading honnef.co/go/tools v0.0.1-2020.1.6
				go: downloading golang.org/x/tools v0.0.0-20200410194907-79a7a3126eef
				go: downloading golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543
				go: downloading github.com/BurntSushi/toml v0.3.1

				"""
			ExitCode: 0
			CmdStr:   "go get honnef.co/go/tools/cmd/staticcheck"
			Negated:  false
		}]
		Order:           1
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "go115_staticcheck_get"
	}
	goversion: {
		Stmts: [{
			ComparisonOutput: """
				go version devel +7307e86afd Sun Nov 8 12:19:55 2020 +0000 linux/amd64

				"""
			Output: """
				go version devel +7307e86afd Sun Nov 8 12:19:55 2020 +0000 linux/amd64

				"""
			ExitCode: 0
			CmdStr:   "go version"
			Negated:  false
		}]
		Order:           0
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "goversion"
	}
}
Hash: "94cde6bab4c997128f516a6425713437875f4ca689dfcda136580ac1bf72a207"
Delims: ["{{{", "}}}"]
