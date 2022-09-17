package out

Terminals: [{
	Name:        "term1"
	Description: "The main terminal"
	Scenarios: {
		go116: {
			Image: "playwithgo/go1.19.1:5966cd5f1b8ef645576f95bcb19fff827d6ca560"
		}
	}
}]
Scenarios: [{
	Name:        "go116"
	Description: "Go 1.16"
}]
Networks: ["playwithgo_pwg"]
Env: []
FilenameComment: false
Steps: {
	goversion: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "goversion"
		Order:           0
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "go version"
			ExitCode:         0
			Output:           "go version go1.19.1 linux/amd64"
			ComparisonOutput: "go version go1.19.1 linux/amd64"
		}]
	}
	go116_mkcert_install: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "go116_mkcert_install"
		Order:           1
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go install filippo.io/mkcert@v1.4.4"
			ExitCode: 0
			Output: """
				go: downloading filippo.io/mkcert v1.4.4
				go: downloading golang.org/x/net v0.0.0-20220421235706-1d1ef9303861
				go: downloading software.sslmate.com/src/go-pkcs12 v0.2.0
				go: downloading golang.org/x/text v0.3.7
				go: downloading golang.org/x/crypto v0.0.0-20220331220935-ae2d96664a29

				"""
			ComparisonOutput: """
				go: downloading filippo.io/mkcert v1.4.4
				go: downloading golang.org/x/net v0.0.0-20220421235706-1d1ef9303861
				go: downloading software.sslmate.com/src/go-pkcs12 v0.2.0
				go: downloading golang.org/x/text v0.3.7
				go: downloading golang.org/x/crypto v0.0.0-20220331220935-ae2d96664a29

				"""
		}]
	}
	which_mkcert: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "which_mkcert"
		Order:           2
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "which mkcert"
			ExitCode: 0
			Output: """
				/home/gopher/go/bin/mkcert

				"""
			ComparisonOutput: """
				/home/gopher/go/bin/mkcert

				"""
		}]
	}
	run_mkcert: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "run_mkcert"
		Order:           3
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "mkcert -version"
			ExitCode: 0
			Output: """
				v1.4.4

				"""
			ComparisonOutput: """
				v1.4.4

				"""
		}]
	}
	goversion_mkcert: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "goversion_mkcert"
		Order:           4
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go version -m $(which mkcert)"
			ExitCode: 0
			Output: """
				/home/gopher/go/bin/mkcert: go1.19.1
				\tpath\tfilippo.io/mkcert
				\tmod\tfilippo.io/mkcert\tv1.4.4\th1:8eVbbwfVlaqUM7OwuftKc2nuYOoTDQWqsoXmzoXZdbc=
				\tdep\tgolang.org/x/crypto\tv0.0.0-20220331220935-ae2d96664a29\th1:tkVvjkPTB7pnW3jnid7kNyAMPVWllTNOf/qKDze4p9o=
				\tdep\tgolang.org/x/net\tv0.0.0-20220421235706-1d1ef9303861\th1:yssD99+7tqHWO5Gwh81phT+67hg+KttniBr6UnEXOY8=
				\tdep\tgolang.org/x/text\tv0.3.7\th1:olpwvP2KacW1ZWvsR7uQhoyTYvKAupfQrRGBFM352Gk=
				\tdep\tsoftware.sslmate.com/src/go-pkcs12\tv0.2.0\th1:nlFkj7bTysH6VkC4fGphtjXRbezREPgrHuJG20hBGPE=
				"""
			ComparisonOutput: """
				/home/gopher/go/bin/mkcert: go1.19.1
				\tpath\tfilippo.io/mkcert
				\tmod\tfilippo.io/mkcert\tv1.4.4\th1:8eVbbwfVlaqUM7OwuftKc2nuYOoTDQWqsoXmzoXZdbc=
				\tdep\tgolang.org/x/crypto\tv0.0.0-20220331220935-ae2d96664a29\th1:tkVvjkPTB7pnW3jnid7kNyAMPVWllTNOf/qKDze4p9o=
				\tdep\tgolang.org/x/net\tv0.0.0-20220421235706-1d1ef9303861\th1:yssD99+7tqHWO5Gwh81phT+67hg+KttniBr6UnEXOY8=
				\tdep\tgolang.org/x/text\tv0.3.7\th1:olpwvP2KacW1ZWvsR7uQhoyTYvKAupfQrRGBFM352Gk=
				\tdep\tsoftware.sslmate.com/src/go-pkcs12\tv0.2.0\th1:nlFkj7bTysH6VkC4fGphtjXRbezREPgrHuJG20hBGPE=
				"""
		}]
	}
}
Hash: "d19823b04cae5f5be42889ac3f5d71ed8700c12a3ac6e15c47c8cbd3fafef345"
Delims: ["{{{", "}}}"]
