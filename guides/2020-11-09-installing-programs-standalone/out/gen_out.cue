package out

Terminals: [{
	Description: "The main terminal"
	Scenarios: {
		go116: {
			Image: "playwithgo/go1.16-tip@sha256:4f6f3820ad3d6c30b623eabe688bfd073eeb4a52c284c80b3e6bc4a3b8cded2a"
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
		Order:           7
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
		Order:           6
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
		Order:           5
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
		Order:           2
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "go116_staticcheck_install"
	}
	go115_staticcheck_install: {
		Stmts: [{
			ComparisonOutput: """
				go: downloading honnef.co/go/tools v0.0.1-2020.1.6
				go: downloading golang.org/x/tools v0.0.0-20200410194907-79a7a3126eef
				go: downloading golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543
				go: downloading github.com/BurntSushi/toml v0.3.1

				"""
			Output: """
				go: downloading honnef.co/go/tools v0.0.1-2020.1.6
				go: downloading golang.org/x/tools v0.0.0-20200410194907-79a7a3126eef
				go: downloading golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543
				go: downloading github.com/BurntSushi/toml v0.3.1

				"""
			ExitCode: 0
			CmdStr: """
				(
				\tcd $(mktemp -d)
				\tGO111MODULE=on go get honnef.co/go/tools/cmd/staticcheck@v0.0.1-2020.1.6
				)
				"""
			Negated: false
		}]
		Order:           1
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "go115_staticcheck_install"
	}
	path_add_gopath_bin: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "export PATH=\"$(go env GOPATH)/bin:$PATH\""
			Negated:          false
		}]
		Order:           4
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "path_add_gopath_bin"
	}
	go_env_gopath: {
		Stmts: [{
			ComparisonOutput: """
				/home/gopher/go

				"""
			Output: """
				/home/gopher/go

				"""
			ExitCode: 0
			CmdStr:   "go env GOPATH"
			Negated:  false
		}, {
			ComparisonOutput: """


				"""
			Output: """


				"""
			ExitCode: 0
			CmdStr:   "go env GOBIN"
			Negated:  false
		}]
		Order:           3
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "go_env_gopath"
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
Hash: "1f8d538927f896b50df9179ee35bb04d1dd7ac219134130cce81b0ea976dd1ae"
Delims: ["{{{", "}}}"]
